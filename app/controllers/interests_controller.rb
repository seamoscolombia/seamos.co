class InterestsController < ApplicationController
  before_action :set_interest, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: :index
  # this skip probably needs to be removed in the future
  skip_before_action :verify_authenticity_token

  def index
    @interests = Interest.all
    respond_to do |format|
      format.json
    end
  end

  def show
  end

  def edit
  end

  def create
    @interest = Interest.new(interest_params)
    respond_to do |format|
      format.json do
        if @interest.save
          render json: @interest, status: :created
        else
          render json: @interest.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        if @interest.update(interest_params)
          render :show, status: :ok, location: @interest
        else
          render json: @interest.errors, status: :unprocessable_entit
        end
      end
    end
  end

  def destroy
    @interest.destroy
    respond_to do |format|
      format.json { head :no_content }
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
