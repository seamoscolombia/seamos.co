# == Schema Information
#
# Table name: vote_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :vote_type do
    name { Faker::Lorem.word }
    poll { FactoryGirl.build(:poll) }
  end
end
