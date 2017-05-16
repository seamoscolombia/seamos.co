json.interests do
  json.array! @interests do |interest|
    json.interest_id interest.tag.id
    json.tag_name interest.tag.name
    json.tag_image interest.tag.tag_image.url
    if interest.user == @user
      json.selected true
    else
      json.selected false
    end
  end
end
