class Debate < ApplicationRecord
  belongs_to :poll
  has_many :questions, inverse_of: :debate 
  accepts_nested_attributes_for :questions
end
