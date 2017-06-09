class InterestsController < ApplicationController
  before_action :set_interest, only: [:association]

  def association
    @interest = Interest.find_by(user_id: params[:user_id])
    if @interest
        @interest.destroy
        render json: {}, status: :no_content
    else
      @interest = Interest.new(interest_params) 
      if @interest.save
        render json: @interest, status: :created
      else
        render json: @interest.errors, status: :unprocessable_entity
      end
    end
  end


  private

    def set_interest
      @interest = Interest.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def interest_params
      params.permit(:user_id, :tag_id)
    end
end
