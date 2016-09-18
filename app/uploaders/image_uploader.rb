class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :extract_exif

  process :right_orientation

  process resize_to_limit: [3000, 4000]

  if Rails.env.development?
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  version :border do
    process :exif_border
  end

  version :thumb do
    process resize_to_limit: [400, 600]
  end

  def right_orientation
    manipulate! do |img|
      img.auto_orient
      img
    end
  end

  def extract_exif
    exif = MiniExiftool.new file.file
    model.model = exif.model
    model.lens = exif.lens
    model.lens_id = exif.lens_id
    model.f_number = exif.f_number
    model.focal_length = exif.focal_length
    model.exposure_time = exif.exposure_time
    model.iso = exif.iso
  end

  # rubocop:disable MethodLength
  def exif_border
    return if model.border_style.nil? || model.exif_string.blank?

    result = nil
    manipulate! do |img|
      basic_point = cal_basic_point(img.dimensions.min)
      border_height = basic_point * 2
      text_v_margin = text_h_margin = basic_point / 2

      img.combine_options do |c|
        c.background model.border_style
        c.gravity    'SouthEast'
        c.splice     "0x#{border_height}"
        c.draw       "text #{text_h_margin},#{text_v_margin} '#{model.exif_string}'"
        c.font       'Lato-Regular'
        c.fill       model.text_color
        c.pointsize  basic_point
        result = c
      end
    end
    result
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  def content_type_whitelist
    %r{image\/}
  end

  def filename
    "#{secure_token}.#{file.extension.downcase}" if original_filename.present?
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid.delete('-'))
  end

  def cal_basic_point(length)
    basic_point = length / 60
    basic_point < 12 ? 12 : basic_point
  end
end
