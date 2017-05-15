# == Schema Information
#
# Table name: interests
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :interest do
    tag { FactoryGirl.create(:tag) }
    user { FactoryGirl.create(:user)}
  end
end
