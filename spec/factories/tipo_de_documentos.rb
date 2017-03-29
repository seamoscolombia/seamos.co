FactoryGirl.define do
  factory :tipo_de_documento do
    codigo { Faker::Lorem.word + rand(300).to_s}
  end
end
