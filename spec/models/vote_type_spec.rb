# == Schema Information
#
# Table name: vote_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'rails_helper'

RSpec.describe VoteType, type: :model do
  describe 'relations' do
    it { should belong_to(:poll) }
  end
  describe 'validations' do
    it { should validate_presence_of(:poll) }
    it { should validate_presence_of(:name) }
  end
end
