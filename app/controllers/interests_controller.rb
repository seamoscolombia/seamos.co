class InterestsController < ApplicationController
  before_action :set_interest, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: :index

  def index
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
          render json: @interest, status: :ok, location: @interest
        else
          render json: @interest.errors, status: :unprocessable_entity
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
