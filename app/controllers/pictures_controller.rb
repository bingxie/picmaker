class PicturesController < ApplicationController
  def index
    @picture = Picture.new
    @pictures = Picture.last 6
  end

  def create
    @picture = Picture.new(params.require(:picture).permit(:border_style, :file_name)) # sequence is important

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render json: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end
end
