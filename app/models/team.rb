class Team < ApplicationRecord
  has_and_belongs_to_many :drivers
  has_and_belongs_to_many :leagues
  belongs_to :user
  validates :name, presence: true, length: {minimum: 2}
  validates :driver_ids, length: {maximum: 5, too_long: "No more than %{count} drivers on a %{model}"}
  scope :current, ->() {where(year: Time.current.year)}
  attribute :year, :integer, default: -> {Time.current.year.to_i}

  def score
    drivers.collect(&:current_position).reduce(:+)
  end
end
