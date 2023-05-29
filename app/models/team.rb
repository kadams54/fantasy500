class Team < ApplicationRecord
  has_and_belongs_to_many :drivers
  has_and_belongs_to_many :leagues
  belongs_to :user
  validates :name, presence: true, length: {minimum: 2}
  validates :driver_ids, length: {maximum: 5, too_long: "No more than %{count} drivers on a %{model}"}
  scope :current, ->() {where(year: Time.current.year)}
  attribute :year, :integer, default: -> {Time.current.year.to_i}

  def score
    # TODO: Handle situations where team does not yet have 5 drivers selected
    drivers.collect(&:current_position).reduce(:+) or 0
  end
end
