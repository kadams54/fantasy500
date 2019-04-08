class Team < ApplicationRecord
  has_and_belongs_to_many :drivers
  validates :name, presence: true, length: {minimum: 2}
  validates :driver_ids, length: {maximum: 5, too_long: "No more than %{count} drivers on a %{model}"}

  def score
    drivers.collect(&:current_position).reduce(:+)
  end
end
