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
  describe 'validations' do
    subject { Subscription.create(email: "validemail@foo.com") }
    it { should validate_uniqueness_of(:email).scoped_to(:email_list_id).ignoring_case_sensitivity.with_message('Ya te has suscrito previamente') }
    it { should allow_value("email@addresse.foo").for(:email) }
    it { should_not allow_value("foo").for(:email) }
  end
end