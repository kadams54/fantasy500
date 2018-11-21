class Driver < ApplicationRecord
  validates :name, presence: true, length: {minimum: 2}
  validates :number, presence: true
  validates :make_model, presence: true, length: {minimum: 2}
end
