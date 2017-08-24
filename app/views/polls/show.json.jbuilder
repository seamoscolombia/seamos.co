url = Rails.env.production? ? '' : 'http://localhost:3000'
json.poll do
    json.id @poll.id
    json.title @poll.title
    json.image url.to_s + @poll.poll_image.url
    json.description @poll.description
    json.objective @poll.objective
    json.initial_time @poll.remaining_time_in_seconds_from_created
    json.remaining @poll.remaining_time_in_seconds
    json.vote_count @poll.votes.size
    json.poll_type @poll.poll_type
    json.status @poll.poll_state
    json.summary @poll.summary
    json.tag do
      tag = @poll.tags.first
      json.id tag.id
      json.name tag.name
      json.color tag.tag_color
    end
    if current_user
      json.user_already_voted current_user.already_voted?(@poll)
      json.user_logged_in true
    else
      json.user_already_voted false
      json.user_logged_in false
    end
    json.links do
      json.array! @poll.external_links do |external_link|
        json.url external_link.url
      end
    end
    json.vote_types do
      json.array! @poll.vote_types do |vote_type|
        json.id vote_type.id
        json.name vote_type.name
        json.count @vote_types[vote_type.name]
      end
    end
    json.politician do
      json.id @poll.user.id
      json.full_name @poll.user.full_name
      json.picture url + @poll.user.admin_photo.url if @poll.user.admin_photo.url
      json.organization @poll.user.organization
      # json.picture "${url}${politician_profile_picture}"
    end
end
