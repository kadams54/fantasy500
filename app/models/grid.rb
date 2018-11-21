class Grid < ApplicationRecord
  has_many :positions
  validates :lap, presence: true
end
