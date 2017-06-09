class InterestsController < ApplicationController
  before_action :set_interest, only: [:association]

  def association
    @interest = Interest.where('user_id=? AND tag_id=?',params[:user_id], params[:interest][:tag_id])
    if @interest.size != 0 
        @interest.first.destroy
        render json: {}, status: :no_content
    else
      @interest = Interest.new(
        user_id: params[:user_id],
        tag_id: params[:interest][:tag_id]
      ) 
      if @interest.save
        render json: @interest, status: :created
      else
        render json: @interest.errors, status: :unprocessable_entity
      end
    end
  end
 
end
