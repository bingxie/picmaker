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
    [custom_model, custom_lens, f_number_s, focal_length_s, exposure_time_s, iso_s].compact.join('   ')
  end

  def custom_model
    return if model.blank?

    minfo = ModelInfo.find_by_raw_model(model)

    return minfo.custom_model if minfo && minfo.custom_model

    ModelInfo.create(raw_model: model) unless minfo

    model
  end

  def custom_lens
    return if lens.blank? && lens_id.blank?

    linfo = LensInfo.where(raw_lens: lens.to_s, raw_lens_id: lens_id.to_s).first

    return linfo.custom_lens if linfo && linfo.custom_lens

    LensInfo.create(raw_lens: lens, raw_lens_id: lens_id) unless linfo

    lens
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
