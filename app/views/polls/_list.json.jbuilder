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
    json.tag_name poll.tags.first.name
    json.politician do
      json.id poll.user.id
      json.full_name poll.user.full_name
      json.picture url + poll.user.admin_photo.url if poll.user.admin_photo.url
      # json.picture "${url}${politician_profile_picture}"
    end
  end
end
