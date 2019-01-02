class Grid < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :drivers, through: :positions
  validates :lap, presence: true
end
