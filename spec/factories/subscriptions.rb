# == Schema Information
#
# Table name: subscriptions
#
#  id            :integer          not null, primary key
#  email         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  email_list_id :integer
#

FactoryGirl.define do
  factory :subscription do
    email { Faker::Internet.email }
  end

end
