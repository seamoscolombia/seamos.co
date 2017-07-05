url = Rails.env.production? ? 'https://seamos-moity-indaba.mybluemix.net' : 'http://localhost:3000'
json.polls do
  json.array! @polls do |poll|
    json.id poll.id
    json.title poll.title
    json.description poll.description
    json.type poll.poll_type
    json.poll_image url + poll.poll_image.url
    json.vote_count poll.vote_count
    json.remaining poll.remaining_time_in_seconds
    if current_user
      json.already_voted current_user.already_voted?(poll)
    else
      json.already_voted false
    end
    json.color poll.tags.first.tag_color
  end
end
