json.tags do
  url = Rails.env.production? ? '' : 'http://localhost:3000'

  json.array! @tags do |tag|
    json.id tag.id
    json.name tag.name
    json.image tag.tag_image.url
    json.icon tag.tag_icon.url
    json.color tag.tag_color
  end
end
