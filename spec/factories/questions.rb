FactoryGirl.define do
  factory :question do
    description { Faker::Lorem.paragraph }
    debate { FactoryGirl.create(:debate) }
  end
end
