class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_authorization, only: [:edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      flash.now[:alert] = 'Something went wrong, please try again.'
      render :edit
    end
  end

  private

  def check_authorization
    redirect_to root_url unless current_user.encoded_id == params[:id]
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :avatar)
  end
end
