url = Rails.env.production? ? '' : 'http://localhost:3000'
json.polls do
  json.array! @polls do |poll|
    json.id poll.id
    json.title poll.title
    json.description poll.description
    json.type poll.poll_type
    json.poll_image url + poll.poll_image.url
    json.vote_count poll.vote_count
    json.remaining poll.remaining_time_in_seconds
    json.color poll.tags.first.tag_color
  end
end
