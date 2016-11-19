class PicturesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:exif]
  before_action :set_picture, only: [:edit, :update, :show]

  layout 'content', only: [:new, :edit]

  def index
    @pictures = current_user.pictures
  end

  def edit
  end

  def show
  end

  def update
    picture_params = params.require(:picture).permit(:place, :tag_list)

    if @picture.update(picture_params)
      redirect_to @picture, notice: '成功发布摄影作品！'
    else
      render :edit, alert: '更新作品信息失败。'
    end
  end

  def create
    @picture = Picture.new(params.require(:picture).permit(:border_style, :file_name)) # sequence is important
    @picture.user = current_user

    respond_to do |format|
      if @picture.save
        DeletePictureJob.set(wait: 30.minutes).perform_later(@picture) if @picture.border_style # TODO: border verison
        format.json { render json: @picture.as_json(only: [:file_name], methods: [:encoded_id]) }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @picture = Picture.new
  end

  def exif
    @picture = Picture.new
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
