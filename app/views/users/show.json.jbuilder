json.user do
  json.id @user.id
  json.full_name @user.full_name
  # TODO decide if we are going to implement this becuse it requires to add facebook permissions
  # json.location @user.location
  json.interests_count @user.tags.count
  json.participations do
    json.count @participations.count
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
