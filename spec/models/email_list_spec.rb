# == Schema Information
#
# Table name: email_lists
#
#  id         :integer          not null, primary key
#  name       :string
#  identifier :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe EmailList, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
