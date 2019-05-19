class League < ApplicationRecord
  has_and_belongs_to_many :teams
  belongs_to :commish, class_name: "User"

  has_secure_password

  validates :name, presence: true
  validates :password, presence: true

  def rank(team)
    ranked_teams = teams.sort_by(&:score)
    ranked_teams.index{|t| t.id == team.id} + 1
  end
end
