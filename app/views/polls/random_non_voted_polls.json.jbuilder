url = Rails.env.production? ? '' : 'http://localhost:3000'
json.polls do
  json.array! @polls do |poll|
    json.id poll.id
    json.image url + poll.poll_image.url
    json.title poll.title
    json.tag_name poll.tags.first.name
    json.color poll.tags.first.tag_color
  end
end
