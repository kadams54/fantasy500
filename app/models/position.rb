class Position < ApplicationRecord
  belongs_to :driver
  belongs_to :grid
  scope :current, ->() {where(year: Time.current.year)}
  attribute :year, :integer, default: -> {Time.current.year.to_i}
end
