# https://gist.github.com/gshaw/378172448fc50dec4841
# NullStorage provider for CarrierWave for use in tests.  Doesn't actually
# upload or store files but allows test to pass as if files were stored and
# the use of fixtures.
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end

CarrierWave.configure do |config|
  # Make the tmp dir work on Heroku
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  if Rails.env.production? || Rails.env.staging?
    config.storage             = :qiniu
    config.qiniu_access_key    = ENV['QINIU_ACCESS_KEY']
    config.qiniu_secret_key    = ENV['QINIU_SECRET_KEY']
    config.qiniu_bucket        = ENV['QINIU_BUCKET']
    config.qiniu_bucket_domain = ENV['QINIU_BUCKET_DOMAIN']
    # config.qiniu_bucket_private = true #default is false
    # config.qiniu_block_size    = 4*1024*1024
    # config.qiniu_protocol      = "http"

    config.qiniu_up_host       = 'http://up.qiniug.com' # uploading server only for overseas
  elsif Rails.env.development?
    config.storage :file
  elsif Rails.env.test?
    # config.storage NullStorage
    config.enable_processing = true
  end
end

module CarrierWave
  module MiniMagick
    def exif_border
      manipulate! do |img|
        basic_point = img.dimensions.min/60
        basic_point = 12 if basic_point < 12

        img.combine_options do |c|
          c.background 'black'
          c.gravity 'SouthEast'
          c.splice "0x#{basic_point*2}"
          c.draw "text #{basic_point/2},#{basic_point/2} '#{@exif_string}'"
          c.font 'Helvetica'
          c.fill 'white'
          c.pointsize basic_point
        end
        img
      end
    end
  end
end
