json.poll do
    json.id @poll.id
    json.title @poll.title
    json.image @poll.poll_image.url
    json.description @poll.description
    json.objective @poll.objective
    json.remaining @poll.remaining_time_in_seconds
    json.vote_count @poll.votes.size
    json.poll_type @poll.poll_type
    if current_user
      json.user_already_voted current_user.already_voted?(@poll)
    else
      json.user_already_voted false
    end
    json.links do
      json.array! @poll.external_links do |external_link|
        json.url external_link.url
      end
    end
    json.politician do
      json.id @poll.user.id
      json.full_name @poll.user.full_name
      # TODO we need to inculde a picture field on users model to access each user profile images
      # json.picture politician_profile_picture
    end
end
