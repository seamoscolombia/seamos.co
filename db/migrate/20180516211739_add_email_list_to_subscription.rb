class AddEmailListToSubscription < ActiveRecord::Migration[5.0]
  def change
    add_reference :subscriptions, :email_list, foreign_key: true
  end
end
