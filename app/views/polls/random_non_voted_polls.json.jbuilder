url = Rails.env.production? ? '' : 'http://localhost:3000'
json.polls do
  json.array! @polls do |poll|
    json.id poll.id
    json.poll_image url + poll.poll_image.url.to_s
    json.title poll.title
    json.tag_name poll.tags.first.try(:name)
    json.color poll.tags.first.try(:tag_color)
    json.is_closed poll.closed?
  end
end
