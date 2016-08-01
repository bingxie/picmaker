require 'test_helper'

class ImageUploaderTest < ActiveSupport::TestCase
  setup do
    @picture = Picture.new
    @image_uploader = ImageUploader.new(@picture, :file_name)
  end

  test 'extension white list' do
    assert_equal %w(jpg jpeg), @image_uploader.extension_white_list
  end
end
