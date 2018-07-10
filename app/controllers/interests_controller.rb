class InterestsController < ApplicationController
  before_action :verify_user

  def association
    @interest = Interest.where('user_id=? AND tag_id=?',params[:user_id], params[:tag_id]).first
    if @interest.present?
        @interest.destroy
        render json: {message: "interest succesfully removed", interest: @interest, status: "deleted"}
    else
      @interest = Interest.new(
        user_id: params[:user_id],
        tag_id: params[:tag_id]
      )
      if @interest.save
        render json: { message: "interest succesfully created", interest: @interest, status: :created}
      else
        render json: @interest.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def verify_user
    unless params[:user_id] && current_user.id.to_s == params[:user_id]
      flash[:warning] = "Acción no permitida"
      redirect_to root_path
    end
  end
end
