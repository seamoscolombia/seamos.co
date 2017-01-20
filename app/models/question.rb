# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  description :string           not null
#  debate_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :debate
  validates :description, presence: true
end
