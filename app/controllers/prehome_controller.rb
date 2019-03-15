class PrehomeController < ApplicationController
  include ApplicationHelper

  before_action :redirect_admin_or_politician_users

  def index
    @blog_posts = HTTParty.get('https://seamosit.github.io/posts.json')
    @politicians = JSON.parse(File.read("app/helpers/politicians.json"))
  end

  private

  def redirect_admin_or_politician_users
    redirect_to admin_dashboard_index_path if current_user && admin_or_politician?(current_user)
  end
end
