class TagSerializer < ActiveModel::Serializer
  attributes :id, :name
  def root
    'tags'
  end
end
