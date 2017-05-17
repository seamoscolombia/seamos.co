# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_image  :string
#

class Tag < ApplicationRecord

  mount_uploader :tag_image, TagImageUploader
  has_many :taggings, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :polls, -> { distinct }, through: :taggings
  validates :name, presence: true, uniqueness: true

  validates :tag_image, presence: true, on: :create
end
