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
    MiniExiftool.new file.file
    # p '----  extract_exif ----'
    # p exif.lens
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
