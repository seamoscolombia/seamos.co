# == Schema Information
#
# Table name: debate_votes
#
#  id          :integer          not null, primary key
#  question_id :integer
#  users_id     :integer
#  debate_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :debate_vote do
    user {FactoryGirl.create(:user)}
    debate { FactoryGirl.create(:debate_with_questions)}
    question { debate.questions.last }
  end
end
