FactoryGirl.define do
  factory :vote do
    poll FactoryGirl.create(:poll)
    usuario FactoryGirl.create(:usuario)
    vote_type FactoryGirl.build(:vote_type)
  end
end
