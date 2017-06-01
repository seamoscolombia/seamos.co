json.interests do
  json.array! @tags do |tag|
    json.tag_id tag.id
    json.tag_name tag.name
    json.tag_image tag.tag_image.url
    json.tag_icon tag.tag_icon.url
    json.tag_color tag.tag_color
    if tag.interests.map(&:user).include?(@user)
      json.selected true
    else
      json.selected false
    end
  end
end
