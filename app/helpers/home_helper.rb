module HomeHelper
  def display_tag_color(poll)
    poll.tags.first.tag_color if poll.tags.present?
  end

  def display_tag_name(poll)
    poll.tags.first.name if poll.tags.present?
  end
end
