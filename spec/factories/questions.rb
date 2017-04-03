# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  description :string           not null
#  debate_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :question do
    description { Faker::Lorem.paragraph }
    debate { FactoryGirl.create(:debate) }
  end
end
