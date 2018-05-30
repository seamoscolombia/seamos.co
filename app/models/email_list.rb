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

class EmailList < ApplicationRecord
  attr_accessor :raw_mail_list
  has_many :subscriptions, dependent: :destroy

  def create_subscriptions(mail_list)
    mail_list.split(',').each do |mail|
      Subscription.create(email: mail.strip, email_list_id: id)
    end
  end
end
