class Driver < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :grids, through: :positions
  has_and_belongs_to_many :teams
  validates :name, presence: true, length: {minimum: 2}
  validates :number, presence: true
  validates :make_model, presence: true, length: {minimum: 2}
  scope :current, ->() {where(year: Time.current.year)}
  attribute :year, :integer, default: -> {Time.current.year.to_i}

  MAKE_MODEL = {
    "H" => "Honda",
    "C" => "Chevrolet"
  }.freeze

  def starting_position
    pos = positions.all.find { |position| position.grid.lap == 0 }
    (pos && pos.place) || 0
  end

  def current_position
    pos = positions.all.max_by { |position| position.grid.lap }
    (pos && pos.place) || 0
  end
end
