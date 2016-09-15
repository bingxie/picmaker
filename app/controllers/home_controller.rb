class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def new_uploads
  end

  def collections
  end

  def index
  end
end
