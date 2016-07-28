# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  file_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Picture < ApplicationRecord
  mount_uploader :file_name, ImageUploader

  def exif_string
    [model, lens, f_number, focal_length, exposure_time, iso].compact.join('   ')
  end
end
