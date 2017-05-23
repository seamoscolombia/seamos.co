json.interests do
  json.array! @interests do |interest|
    json.id interest.id
    json.user interest.user
    json.tag interest.tag
  end
end
