class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :extract_exif

  process :exif_border

  if Rails.env.development?
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
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

  def exif_border
    return if model.exif_string.blank?
    result = nil
    manipulate! do |img|
      basic_point = img.dimensions.min / 60
      basic_point = 12 if basic_point < 12
      border_height = basic_point * 2
      text_v_margin = basic_point / 2
      text_h_margin = basic_point / 2

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
      img
    end
    result
  end

  def extension_white_list
    %w(jpg jpeg)
  end

  def filename
    random_filename if super.present?
  end

  private

  def random_filename
    @prefix ||= SecureRandom.uuid.delete('-')
    "#{@prefix}.#{file.extension.downcase}"
  end
end
