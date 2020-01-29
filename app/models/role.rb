class Role < ApplicationRecord
  has_many :user

  validates :name, presence: true, uniqueness: true
  validates :permissions, presence: true
end
