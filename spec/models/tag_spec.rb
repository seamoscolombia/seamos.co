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
#

require 'rails_helper'
RSpec.describe Tag, type: :model do
  describe 'relations' do
    it { should have_many(:taggings) }
    it { should have_many(:polls) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:tag_image) }
    it { should validate_presence_of(:tag_icon) }
    it { should validate_presence_of(:tag_color) }
  end
end
