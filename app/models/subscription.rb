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

class Subscription < ApplicationRecord
  validates_uniqueness_of :email, :scope => [:email_list_id], message: "Ya te has suscrito previamente"
  validates  :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/,
                     :message => "Formato de email inválido"}
end
