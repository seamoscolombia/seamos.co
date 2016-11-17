class PhotosController < ApplicationController
  def create
    @document_photo =  DocumentPhoto.new(url: params[:photo])
    if @document_photo.save
      puts @document_photo
      puts @document_photo.id
      render json: {id: @document_photo.id, status: :created }, status: :created
    else
      render json: {status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end
end
