# == Schema Information
#
# Table name: globals
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Global < ApplicationRecord
end
