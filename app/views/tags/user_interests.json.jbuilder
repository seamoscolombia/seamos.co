json.interests do
  json.array! @tags do |tag|
    json.id tag.id
    json.name tag.name
    json.image tag.tag_image.url
    json.thumbnail tag.thumbnail.url
    json.icon tag.tag_icon.url
    json.color tag.tag_color
    if tag.interests.map(&:user).include?(@user)
      json.selected true
    else
      json.selected false
    end
  end
end
