json.debates do
  json.array! @debates do |debate|
    json.id debate.id
    json.title debate.title
    json.poll_id debate.poll.id
    json.questions debate.questions do |qs|
      json.id qs.id
      json.description qs.description
    end
  end
end
