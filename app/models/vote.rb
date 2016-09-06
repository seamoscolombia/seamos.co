# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  poll_id      :integer
#  usuario_id   :integer
#  vote_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :usuario
  belongs_to :vote_type
end
