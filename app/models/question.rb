class Question < ApplicationRecord
  belongs_to :debate
  validates :description, presence: true
end
