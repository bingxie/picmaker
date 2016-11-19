require 'test_helper'

class ImageUploaderTest < ActiveSupport::TestCase
  include ActiveSupport::Testing::FileFixtures

  setup do
    picture = pictures(:one)
    @image_uploader = ImageUploader.new(picture, :file_name)
  end

  test 'extension white list' do
    assert_equal %w(jpg jpeg), @image_uploader.extension_white_list
  end

  class ProcessTest < ImageUploaderTest
    setup do
      ImageUploader.enable_processing = false
      test_file = File.join(file_fixture_path, 'DSC_3264.JPG')
      @copy_test_file = File.join(file_fixture_path, 'DSC_3264_copy.JPG')
      FileUtils.cp(test_file, @copy_test_file)

      @image_uploader.stubs(:cached?).returns(true)
      @image_uploader.stubs(:file).returns(CarrierWave::SanitizedFile.new(@copy_test_file))
    end

    teardown do
      ImageUploader.enable_processing = true
      FileUtils.rm(@copy_test_file) if File.exist?(@copy_test_file)
    end

    test 'adds correct options to process the image' do
      result = @image_uploader.exif_border
      result.args.pop
      args = Hash[*result.args]

      assert_equal 'SouthEast', args['-gravity']
      assert_equal 'Lato-Regular', args['-font']
    end
  end
end
