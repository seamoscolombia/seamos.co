# == Schema Information
#
# Table name: subscriptions
#
#  id            :integer          not null, primary key
#  email         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  email_list_id :integer
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
