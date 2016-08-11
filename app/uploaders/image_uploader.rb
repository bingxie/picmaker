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
