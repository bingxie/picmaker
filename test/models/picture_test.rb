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

require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  setup do
    @picture = pictures(:one)
  end

  test '#custom_model when it already has' do
    picture2 = pictures(:two)
    assert_equal 'SONY A850', picture2.custom_model
  end

  test '#custom_model when it is waiting' do
    picture3 = pictures(:three)
    custom_model = ''
    assert_no_difference 'ModelInfo.count' do
      custom_model = picture3.custom_model
    end
    assert_equal picture3.model, custom_model
  end

  test '#custom_model when it is first one' do
    picture4 = pictures(:four)

    custom_model = ''
    assert_difference 'ModelInfo.count' do
      custom_model = picture4.custom_model
    end
    assert_equal picture4.model, custom_model
  end

  test '#custom_lens when it already has' do
    picture2 = pictures(:two)
    assert_equal 'AF-S DX 17-55mm f/2.8', picture2.custom_lens
  end

  test '#custom_lens when it is waiting' do
    picture3 = pictures(:three)
    custom_lens = ''
    assert_no_difference 'LensInfo.count' do
      custom_lens = picture3.custom_lens
    end
    assert_equal picture3.lens, custom_lens
  end

  test '#custom_lens when it is frst one' do
    picture4 = pictures(:four)
    custom_lens = ''

    assert_difference 'LensInfo.count' do
      custom_lens = picture4.custom_lens
    end

    assert_equal picture4.custom_lens, custom_lens
  end

  test '#exif_string' do
    expected = 'NIKON D7000   AF-S DX 17-55mm f/2.8   F5.0   30mm   1/1600s   ISO200'
    assert_equal expected, @picture.exif_string
  end

  test '#f_number_s' do
    assert_equal 'F5.0', @picture.f_number_s
  end

  test '#focal_length_s' do
    assert_equal '30mm', @picture.focal_length_s
  end

  test '#exposure_time_s' do
    assert_equal '1/1600s', @picture.exposure_time_s
  end

  test '#iso_s' do
    assert_equal 'ISO200', @picture.iso_s
  end

  test '#text_color' do
    @picture.border_style = 'white'
    assert_equal 'black', @picture.text_color

    @picture.border_style = 'black'
    assert_equal 'white', @picture.text_color
  end

  test 'create a picture' do
    picture = Picture.create(file_name: fixture_file_upload('files/DSC_3264.JPG', 'image/jpg'), border_style: 'white')

    assert_equal 'NIKON D7000', picture.model
    assert_equal '35mm f/1.8', picture.lens
    assert_equal 'AF-S DX Nikkor 35mm f/1.8G', picture.lens_id
    assert_equal '2.8', picture.f_number
    assert_equal '35.0 mm', picture.focal_length
    assert_equal '1/320', picture.exposure_time
    assert_equal '200', picture.iso
    assert_equal 'white', picture.border_style

    assert_equal 'DSC_3264.JPG', picture.file_name.instance_variable_get('@filename')
  end
end
