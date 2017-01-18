# == Schema Information
#
# Table name: debate_votes
#
#  id          :integer          not null, primary key
#  question_id :integer
#  usuario_id  :integer
#  debate_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DebateVote < ApplicationRecord
  belongs_to :debate
  belongs_to :usuario
  belongs_to :question
end
