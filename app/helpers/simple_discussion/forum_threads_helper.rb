module SimpleDiscussion::ForumThreadsHelper
  # Used for flagging links in the navbar as active
  def forum_link_to(path, opts={}, &block)
    link_to path, class: forum_link_class(path, opts), &block
  end

  def forum_link_class(matches, opts={})
    case matches
    when Array
      "active" if matches.any?{ |m| request.path.starts_with?(m) }
    when String
      "active" if opts.fetch(:exact, false) ? request.path == matches : request.path.starts_with?(matches)
    end
  end

  def preview_comments(forum_thread)
    first_post = forum_thread.forum_posts.find{ |fp| fp.first_post == true }
    most_voted_posts = forum_thread.forum_posts.most_voted_first.first(3).reject{ |post| post == first_post}
    sanitized_first_comment_body = sanitize(first_post&.body&.first(500).to_s, :tags=>[])
    @preview_comments = [sanitized_first_comment_body] + most_voted_posts.map{|ft| build_comment_preview(ft)}
  end


  # A nice hack to manipulate the layout so we can have sub-layouts
  # without any changes in the user's application.
  #
  # We use this for rendering the sidebar layout for all the forum pages
  #
  # https://mattbrictson.com/easier-nested-layouts-in-rails
  #
  def parent_layout(layout)
    @view_flow.set(:layout, output_buffer)
    output = render(file: "layouts/#{layout}")
    self.output_buffer = ActionView::OutputBuffer.new(output)
  end

  private

  def build_comment_preview(forum_post)
    "<strong> #{forum_post.user.names} </strong>: #{sanitize(forum_post.body.first(200).to_s + ' ...', :tags=>[])}" if forum_post
  end
end
