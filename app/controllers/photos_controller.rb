class PhotosController < ApplicationController
  def create
    @photo = Photo.save(url: params[:photo])
    if @photo.save
      render json:{id: @photo.id}, status: :created }
    else
      render json: {}, status: :unprocessable_entity
    end
  end
end
