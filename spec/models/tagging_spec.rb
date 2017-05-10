# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Tagging, type: :model do
  describe 'relations' do
    it { should belong_to(:poll) }
    it { should belong_to(:tag) }
  end
end
