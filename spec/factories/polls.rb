FactoryGirl.define do
  factory :poll do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    closing_date { Date.tomorrow }
    totals "{1=>#{Faker::Number.number(3)}, 2=>#{Faker::Number.number(3)}}"
    to_create { |instance| instance.save(validate: false) }

    factory :poll_with_votes do
      after(:create) do |poll|
        5.times do
          poll.votes << FactoryGirl.create(:vote)
        end
      end
    end
    factory :poll_with_votes_and_debates do
      after(:create) do |poll|
        5.times do
          poll.votes << FactoryGirl.create(:vote)
          poll.debates << FactoryGirl.create(:debate_with_questions)
        end
      end
    end
  end
end
