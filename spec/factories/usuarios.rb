FactoryGirl.define do
  factory :usuario do

    primer_apellido { Faker::Name.last_name }
    segundo_apellido { Faker::Name.last_name }
    nombres { Faker::Name.first_name }
    tipo_de_documento FactoryGirl.build(:tipo_de_documento)
    fecha_expedicion { Date.today - 1000.days }
    valido false
    email { Faker::Internet.email }
    password "password123@"
    password_confirmation "password123@"
    role_type { rand(0..2) }
    to_create {|instance| instance.save(validate: false) }

  end
end
