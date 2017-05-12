FactoryGirl.define do
  factory :poll_state do
    name "MyString"
    status 1
    ordinal_position 1
    poll { FactoryGirl.create(:poll)}
  end
end
