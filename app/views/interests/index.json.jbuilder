json.interests do
  json.array! @tags do |tag|
    json.tag_id tag.id
    json.tag_name tag.name
    json.tag_image tag.tag_image.url
    if tag.interests.map(&:user).include?(@user)
      json.selected true
    else
      json.selected false
    end
  end
end
