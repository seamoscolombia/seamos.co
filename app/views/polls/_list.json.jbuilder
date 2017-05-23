json.polls do
  json.array! @polls do |poll|
    json.id poll.id
    json.title poll.title
    json.description poll.description
    json.type poll.poll_type
    if current_user
      json.already_voted current_user.already_voted?(poll) 
    else
      json.already_voted false
    end
  end
end
