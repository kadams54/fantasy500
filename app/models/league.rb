class League < ApplicationRecord
  has_and_belongs_to_many :teams
  belongs_to :commish, class_name: "User"

  has_secure_password

  validates :name, presence: true
  validates :password, presence: true
end
