# == Schema Information
#
# Table name: causes
#
#  id          :integer          not null, primary key
#  description :text
#  title       :string
#  usuario_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cause < ApplicationRecord
  belongs_to :usuario

  validates_presence_of  [:description, :title]
end
