class League < ApplicationRecord
  attr_accessor :membership_token

  before_save :create_membership_digest

  has_and_belongs_to_many :teams
  belongs_to :commish, class_name: "User"

  validates :name, presence: true

  scope :current, ->() {where(year: Time.current.year)}

  attribute :year, :integer, default: -> {Time.current.year.to_i}

  def rank(team)
    ranked_teams = teams.sort_by(&:score)
    ranked_teams.index{|t| t.id == team.id} + 1
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def send_membership_emails(emails)
    emails.each do |email|
      LeagueMailer.membership(email, self).deliver_now
    end
  end

  private

  def create_membership_digest
    self.membership_token = User.new_token
    self.membership_digest = User.digest(membership_token)
  end
end
