class Poll < ApplicationRecord
  belongs_to :usuario
  
  validates :title, presence: true
  validates :description, presence: true
end
