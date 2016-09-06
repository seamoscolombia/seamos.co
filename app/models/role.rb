# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ApplicationRecord
  validates :code, presence: true, uniqueness: true
end
