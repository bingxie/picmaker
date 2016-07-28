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
    # p '----  extract_exif ----'
    # p exif.lens
    @exif_string =
      [exif.model, exif.lens, exif.f_number, exif.focal_length, exif.exposure_time, exif.iso].compact.join('   ')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
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
