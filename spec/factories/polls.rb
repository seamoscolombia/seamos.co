FactoryGirl.define do
#        poll_image: string)

  factory :poll do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    closing_date { Date.tomorrow }
    totals "{1=>#{Faker::Number.number(3)}, 2=>#{Faker::Number.number(3)}}"
    to_create {|instance| instance.save(validate: false) }


    # factory :poll_with_votes do
    #   after(:create) do |poll|
    #   end
    # end
  end
end
