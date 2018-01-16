json.tags do
  url = Rails.env.production? ? '' : 'http://localhost:3000'

  json.array! @tags do |tag|
    json.id tag.id
    json.name tag.name
    json.image tag.tag_image.url
    json.thumbnail tag.thumbnail.url
    json.icon tag.tag_icon.url
    json.color tag.tag_color
    json.polls_count tag.polls.size
  end
end
