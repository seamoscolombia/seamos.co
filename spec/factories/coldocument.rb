# == Schema Information
#
# Table name: coldocuments
#
#  doc_num    :integer
#  divipol_id :integer
#

FactoryGirl.define do
  factory :coldocument do
    doc_num { Faker::Number.number(10) }
    divipol_id { '12341234' }
   end
end
