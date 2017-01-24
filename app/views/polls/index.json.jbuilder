json.polls do
  url = Rails.env.production? ? '' : 'http://localhost:3000'

  json.array! @polls do |poll|
    json.id poll.id
    json.title poll.title
    json.description poll.description
    json.closing_date poll.closing_date
    json.poll_image "#{url}#{poll.poll_image_url}"
    if current_user
      json.already_voted current_user.already_voted?(poll)
    else
      json.already_voted false
    end
    json.vote_types poll.vote_types do |vt|
      json.id vt.id
      json.name vt.name
    end
  end
end
