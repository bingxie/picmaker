class ImageUploader < CarrierWave::Uploader::Base

  process :extract_exif

  if Rails.env.development?
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def extract_exif
    exif = MiniExiftool.new file.file
    p '----  extract_exif ----'
    p exif.lens
  end

  protected

  def secure_token
    variable = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(variable) or model.instance_variable_set(variable, SecureRandom.uuid)
  end
end
