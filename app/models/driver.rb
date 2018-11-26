class Driver < ApplicationRecord
  has_many :positions
  has_many :grids, through: :positions
  has_and_belongs_to_many :teams
  validates :name, presence: true, length: {minimum: 2}
  validates :number, presence: true
  validates :make_model, presence: true, length: {minimum: 2}

  def starting_position
    positions.find { |position| position.grid.lap == 0 }.place
  end

  def current_position
    positions.max_by { |position| position.grid.lap }.place
  end
end
