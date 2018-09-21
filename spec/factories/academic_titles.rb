# == Schema Information
#
# Table name: academic_titles
#
#  id         :integer          not null, primary key
#  title      :string
#  period     :string
#  institute  :string
#  annotation :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :academic_title do
    title { Faker::Lorem.word }
    period { Faker::Lorem.word }
    institute { Faker::Lorem.word }
    annotation { Faker::Lorem.word }
    user nil
  end
end
