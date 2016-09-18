class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def new_uploads
    @pictures = Picture.order(created_at: :asc).last(10)
  end

  def collections
  end

  def index
  end
end
