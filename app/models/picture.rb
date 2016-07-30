# == Schema Information
#
# Table name: pictures
#
#  id            :integer          not null, primary key
#  file_name     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  border_style  :string           default("black"), not null
#  model         :string
#  lens          :string
#  f_number      :string
#  focal_length  :string
#  exposure_time :string
#  iso           :string
#

class Picture < ApplicationRecord
  mount_uploader :file_name, ImageUploader

  def exif_string
    [model, lens, f_number_s, focal_length_s, exposure_time_s, iso_s].compact.join('   ')
  end

  def f_number_s
    "F#{f_number}" if f_number.present?
  end

  def focal_length_s
    focal_length.split('.')[0] + 'mm' if focal_length.present?
  end

  def exposure_time_s
    exposure_time + 's' if exposure_time.present?
  end

  def iso_s
    'ISO' + iso if iso.present?
  end
end
