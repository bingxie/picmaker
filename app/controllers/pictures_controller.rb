class PicturesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :new]

  layout 'content', only: [:new]

  def index
    @pictures = current_user.pictures
  end

  def create
    @picture = Picture.new(params.require(:picture).permit(:border_style, :file_name)) # sequence is important

    respond_to do |format|
      if @picture.save
        DeletePictureJob.set(wait: 30.minutes).perform_later(@picture) if @picture.border_style # TODO: border verison
        format.json { render json: @picture }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @picture = Picture.new
  end

  def border
    @picture = Picture.new
  end
end
