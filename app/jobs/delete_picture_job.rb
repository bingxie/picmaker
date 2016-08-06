class DeletePictureJob < ApplicationJob
  queue_as :default

  def perform(picture)
    picture.remove_file_name!
  end
end
