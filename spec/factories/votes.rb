# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  poll_id      :integer
#  usuario_id   :integer
#  vote_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :vote do
    poll { FactoryGirl.create(:poll)}
    user { FactoryGirl.create(:user)}
    vote_type { FactoryGirl.build(:vote_type)}
  end
end
