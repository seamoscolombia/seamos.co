json.user do
  json.id @user.id
  json.full_name @user.full_name
  json.interests_count @user.tags.size
  json.participations do
    json.count @participations.size
      json.polls do
      json.array! @participations do |poll|
      json.id poll.id
      json.title poll.title
      json.remaining poll.remaining_time_in_seconds
      end
    end
  end
  json.authenticity_token form_authenticity_token
end
