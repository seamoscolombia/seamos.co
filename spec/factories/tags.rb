# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_image  :string
#  tag_icon   :string
#  tag_color  :string
#  thumbnail  :string
#

FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.word + SecureRandom.hex }
    tag_image { File.open("#{Rails.root}/spec/support/image.png", 'r') }

  end
end
