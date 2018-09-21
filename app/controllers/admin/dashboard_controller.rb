class Admin::DashboardController < ApplicationController
  before_action :validate_session
  before_action :validate_admin_user, only: :stats
  before_action :validate_admin_or_politician, only: :index


  def stats
    @polls = Poll.all.includes(:votes)
    @open_polls = @polls.open
    @closed_polls = @polls.closed
    @citizens = User.where(role_type: 0).includes(:votes)
    @vote_average = calculate_vote_average(@citizens).round(1)
    @non_votant_users = @citizens.select{|u| u.votes.size == 0}.size
    @votant_users = @citizens.select{|u| u.votes.size > 0}.size
    @global_vote_count = Vote.count
  end

  private

    def calculate_vote_average(users)
      vote_count_array = users.map{|u| u.vote_count}
      vote_count_array.inject{ |sum, el| sum + el }.to_f / vote_count_array.size
    end

    def validate_admin_user
       unless current_user.role_type == "administrador"
         redirect_to root_path
       end
    end
end
