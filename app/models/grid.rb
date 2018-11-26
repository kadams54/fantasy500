class Grid < ApplicationRecord
  has_many :positions
  has_many :drivers, through: :positions
  validates :lap, presence: true
end
