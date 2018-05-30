# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  first_surname      :string
#  segundo_apellido     :string
#  names              :string
#  tipo_de_documento_id :integer
#  document_number     :string
#  fecha_expedicion     :date
#  role_type            :integer
#  uid                  :string
#  approved               :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_photo_id    :integer
#  email                :string
#  password_hash        :string
#  password_salt        :string
#

FactoryGirl.define do
  factory :user do

    first_surname { Faker::Name.last_name }
    second_surname { Faker::Name.last_name }
    names { Faker::Name.first_name }
    approved false
    email { Faker::Internet.email }
    password "password123@"
    password_confirmation "password123@"
    role_type { rand(0..2) }
    to_create {|instance| instance.save(validate: false) }

  end
end
