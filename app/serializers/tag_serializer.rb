# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagSerializer < ActiveModel::Serializer
  attributes :id, :name
  def root
    'tags'
  end
end
