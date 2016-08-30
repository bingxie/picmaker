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
#  lens_id       :string
#  user_id       :integer
#

class Picture < ApplicationRecord
  acts_as_taggable

  mount_uploader :file_name, ImageUploader

  def exif_string
    [custom_model, custom_lens, f_number_s, focal_length_s, exposure_time_s, iso_s].compact.join('   ')
  end

  def custom_model
    return if model.blank?

    minfo = ModelInfo.find_or_create_by(raw_model: model)

    minfo.custom_model || model
  end

  def custom_lens
    return if lens.blank? && lens_id.blank?

    params = { raw_lens: lens }
    params[:raw_lens_id] = lens_id if lens_id.present?

    linfo = LensInfo.find_or_create_by(params)

    linfo.custom_lens || lens
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

  def text_color
    border_style == 'white' ? 'black' : 'white'
  end
end
