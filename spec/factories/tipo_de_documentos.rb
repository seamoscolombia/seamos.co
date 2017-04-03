# == Schema Information
#
# Table name: tipo_de_documentos
#
#  id         :integer          not null, primary key
#  codigo     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :tipo_de_documento do
    codigo { Faker::Lorem.word + rand(300).to_s}
  end
end
