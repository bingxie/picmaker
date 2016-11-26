class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def new_uploads
    @pictures = NewPicturesQuery.call.last(10)
  end

  def collections
  end

  def index
  end
end
