class Tag < ApplicationRecord
  has_many :taggings
  has_many :polls, through: :taggings
  validates :name, presence: true
end
