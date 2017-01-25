json.debates do
  json.array! @debates do |debate|
    json.id debate.id
    json.title debate.title
    json.poll_id debate.poll.id
    if current_user
      json.already_voted current_user.debate_already_voted?(debate)
    else
      json.already_voted false
    end
    json.questions debate.questions do |qs|
      json.id qs.id
      json.description qs.description
    end
  end
end
