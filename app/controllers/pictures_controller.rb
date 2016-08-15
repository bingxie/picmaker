class PicturesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @pictures = current_user.pictures
  end

  def create
    @picture = Picture.new(params.require(:picture).permit(:border_style, :file_name)) # sequence is important

    respond_to do |format|
      if @picture.save
        DeletePictureJob.set(wait: 30.minutes).perform_later(@picture)
        format.json { render json: @picture }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @picture = Picture.new
  end
end
