FactoryGirl.define do
  factory :poll do
    factory :poll_with_votes do
      after(:create) do |poll|
      end
    end
  end
end
