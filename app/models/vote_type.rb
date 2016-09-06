# == Schema Information
#
# Table name: vote_types
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VoteType < ApplicationRecord
  validates :code, presence: true
end
