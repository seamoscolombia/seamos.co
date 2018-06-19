module HomeHelper
  def display_tag_color(poll)
    poll.tags.first.tag_color
  end

  def display_tag_name(poll)
    poll.tags.first.name
  end
end
