# == Schema Information
#
# Table name: pictures
#
#  id            :integer          not null, primary key
#  file_name     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  border_style  :string
#  model         :string
#  lens          :string
#  f_number      :string
#  focal_length  :string
#  exposure_time :string
#  iso           :string
#  lens_id       :string
#  user_id       :integer
#  place         :string
#

require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  setup do
    @picture = pictures(:one)
  end

  should validate_presence_of(:user)

  test '#custom_model when it already has' do
    picture = pictures(:two)
    assert_equal 'SONY A850', picture.custom_model
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
    picture = pictures(:four)

    custom_model = ''
    assert_difference 'ModelInfo.count' do
      custom_model = picture.custom_model
    end
    assert_equal picture.model, custom_model
  end

  test '#custom_lens when it already has' do
    picture = pictures(:two)
    assert_equal 'AF-S DX 17-55mm f/2.8', picture.custom_lens
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
    picture = pictures(:four)
    custom_lens = ''

    assert_difference 'LensInfo.count' do
      custom_lens = picture.custom_lens
    end

    assert_equal picture.custom_lens, custom_lens
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
end
