FactoryGirl.define do
  factory :external_link do
    url "http://#{Faker::Lorem.word}.net"
  end

end
