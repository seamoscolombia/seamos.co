FactoryGirl.define do
  factory :vote_type do
    name { Faker::Lorem.word }
    poll { FactoryGirl.build(:poll) }
  end
end
