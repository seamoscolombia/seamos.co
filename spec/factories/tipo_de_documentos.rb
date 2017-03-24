FactoryGirl.define do
  factory :tipo_de_documento do
    codigo { Faker::Lorem.word }
  end
end
