module ApplicationHelper
  require "net/http"

  def admin_or_politician?(user)
    return false unless user
    user.administrador? || user.politico?
  end
end
