module ApplicationHelper
  require "net/http"

  def admin_or_politician?(user)
    return false unless user
    user.administrador? || user.politico?
  end

  def url_exists?(url_string)
    return false unless url_string
    url = URI.parse(url_string)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path if url.path.present?
    res = req.request_head(path || '/')
    res.code != "404" # false if returns 404 - not found
  rescue Errno::ENOENT
    false # false if can't find the server
  end
end
