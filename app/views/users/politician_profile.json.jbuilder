url = Rails.env.production? ? '' : 'http://localhost:3000'
json.user do
  json.id @user.id
  json.full_name @user.full_name
  json.short_name "#{@user.names}  #{@user.first_surname}"
  json.birthplace @user.birthplace
  json.organization @user.organization
  json.bio @user.bio
  json.picture @user.admin_photo.url
  json.further_studies @user.further_studies
  json.commission @user.current_corporation_commission
  json.initiatives @user.proposed_initiatives_to_date
  json.last_vote_count @user.last_election_vote_count
  json.localities @user.major_electoral_representation_localities
  json.represented_organizations @user.represented_organizations
  json.polls do
    json.array! @polls do |poll|
      json.id poll.id
      json.title poll.title
      json.summary poll.summary
      json.type poll.poll_type
      json.poll_image poll.poll_image.url
      json.vote_count poll.votes.size
      json.remaining poll.remaining_time_in_seconds
      json.is_closed poll.closed?
      json.color poll.tags.first.tag_color
      json.tag_name poll.tags.first.name
      json.tag do
        json.color poll.tags.first.tag_color
      end
      json.politician do
        json.id @user.id
        json.full_name @user.full_name
        json.picture url + @user.admin_photo.url if @user.admin_photo.url
      end
    end
  end
  json.closed_polls do
    json.array! @closed_polls do |poll|
      json.id poll.id
      json.title poll.title
      json.description poll.description
      json.type poll.poll_type
      json.poll_image poll.poll_image.url
      json.vote_count poll.votes.size
      json.remaining poll.remaining_time_in_seconds
      json.tag do
        json.color poll.tags.first.tag_color
      end
    end
  end
  json.authenticity_token form_authenticity_token
end
