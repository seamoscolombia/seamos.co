FactoryGirl.define do
  factory :debate do
    title { Faker::Lorem.paragraph }
    usuario { FactoryGirl.create(:usuario) }
    poll { FactoryGirl.create(:poll) }
    to_create { |instance| instance.save(validate: false) }
    factory :debate_with_questions do
      after(:create) do |debate|
        2.times do
          debate.questions << FactoryGirl.create(:question, debate: debate)
        end
      end
    end
  end
end
