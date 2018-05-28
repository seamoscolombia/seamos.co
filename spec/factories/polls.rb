# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  title         :string           not null
#  description   :text             not null
#  closing_date  :date             not null
#  user_id       :integer
#  totals        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  poll_image    :string
#  active        :boolean          default(TRUE)
#  poll_document :string
#  poll_type     :integer
#  objective     :string
#

FactoryGirl.define do
  factory :poll do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    closing_date { Date.tomorrow }
    totals "{1=>#{Faker::Number.number(3)}, 2=>#{Faker::Number.number(3)}}"
    poll_type 0
    to_create { |instance| instance.save(validate: false) }
    user { FactoryGirl.create(:user) }
    objective { Faker::Lorem.sentence }

    factory :poll_with_votes do
      after(:create) do |poll|
        5.times do
          poll.votes << FactoryGirl.create(:vote)
        end
      end
    end
  end
end
