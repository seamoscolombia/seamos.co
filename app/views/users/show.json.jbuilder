url = Rails.env.production? ? '' : 'http://localhost:3000'
json.user do
  json.id @user.id
  json.full_name @user.full_name
  json.short_name "#{@user.names}  #{@user.first_surname}"
  json.tags do
    json.array! @user.tags do |tag|
      json.id tag.id
      json.name tag.name
      json.image tag.tag_image.url
      json.thumbnail tag.thumbnail.url
      json.icon tag.tag_icon.url
      json.color tag.tag_color
    end
  end
  json.participations do
    json.count @participations.size
      json.polls do
        json.array! @participations do |poll|
          json.id poll.id
          json.title poll.title
          json.description poll.description
          json.type poll.poll_type
          json.poll_image poll.poll_image.url
          json.vote_count poll.votes.size
          json.remaining poll.remaining_time_in_seconds
          json.summary poll.summary
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
  end
  json.authenticity_token form_authenticity_token
  json.picture session[:fb_image]
  json.location session[:fb_location]
end
