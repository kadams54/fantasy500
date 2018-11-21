class Driver < ApplicationRecord
  has_many :positions
  validates :name, presence: true, length: {minimum: 2}
  validates :number, presence: true
  validates :make_model, presence: true, length: {minimum: 2}
end
