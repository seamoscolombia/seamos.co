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

require 'rails_helper'

RSpec.describe Interest, type: :model do
  describe 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:tag) }
  end
end
