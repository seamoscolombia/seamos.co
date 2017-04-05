class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :polls, -> { distinct }, through: :taggings
  validates :name, presence: true
end
