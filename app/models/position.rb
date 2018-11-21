class Position < ApplicationRecord
  belongs_to :driver
  belongs_to :grid
end
