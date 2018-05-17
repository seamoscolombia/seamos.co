class Subscription < ApplicationRecord
  validates_uniqueness_of :email, :scope => [:email_list_id], message: "Ya te has suscrito previamente"
  validates  :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/,
                     :message => "Formato de email inválido"}
end
