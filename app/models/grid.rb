class Grid < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :drivers, through: :positions
  validates :lap, presence: true
  scope :current, ->() {where(year: Time.current.year)}
  scope :past, ->() {where.not(year: Time.current.year)}
  attribute :year, :integer, default: -> {Time.current.year.to_i}
end
