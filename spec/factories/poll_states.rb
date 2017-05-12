# == Schema Information
#
# Table name: poll_states
#
#  id               :integer          not null, primary key
#  name             :string
#  status           :integer
#  ordinal_position :integer
#  poll_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :poll_state do
    name "MyString"
    status 1
    ordinal_position 1
    poll { FactoryGirl.create(:poll)}
  end
end
