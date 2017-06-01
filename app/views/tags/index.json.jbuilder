json.tags do
  url = Rails.env.production? ? '' : 'http://localhost:3000'

  json.array! @tags do |tag|
    json.id tag.id
    json.name tag.name
    json.tag_image tag.tag_image.url
    json.tag_icon tag.tag_icon.url
    json.tag_color tag.tag_color
  end
end
