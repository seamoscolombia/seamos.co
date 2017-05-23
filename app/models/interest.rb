# == Schema Information
#
# Table name: interests
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Interest < ApplicationRecord
  belongs_to :tag
  belongs_to :user
end
