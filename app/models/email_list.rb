class EmailList < ApplicationRecord
  attr_accessor :raw_mail_list
  has_many :subscriptions, dependent: :destroy

  def create_subscriptions(mail_list)
    mail_list.split(',').each do |mail|
      Subscription.create(email: mail.strip, email_list_id: id)
    end
  end
end
