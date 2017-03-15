# == Schema Information
#
# Table name: debates
#
#  id         :integer          not null, primary key
#  title      :string
#  published  :boolean          default(FALSE)
#  poll_id    :integer
#  usuario_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Debate < ApplicationRecord
  belongs_to :usuario
  belongs_to :poll
  has_many :questions, inverse_of: :debate, dependent: :destroy
  has_many :debate_votes, inverse_of: :debate, dependent: :destroy
  accepts_nested_attributes_for :questions

  validates :questions, length: { minimum: 2,  maximum: 4 }

end
