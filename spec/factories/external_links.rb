# == Schema Information
#
# Table name: external_links
#
#  id              :integer          not null, primary key
#  url             :string
#  poll_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_project_link :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :external_link do
    url "http://#{Faker::Lorem.word}.net"
    poll { FactoryGirl.create(:poll)}
  end

end
