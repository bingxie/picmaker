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
  setup do
    @picture = pictures(:one)
  end

  test '#exif_string' do
    expected = 'NIKON D7000   17-55mm f/2.8   F5.0   30mm   1/1600s   ISO200'
    assert_equal expected, @picture.exif_string
  end

  test '#f_number_s' do
    assert_equal 'F5.0', @picture.f_number_s
  end

  test '#focal_length_s' do
    assert_equal '30mm', @picture.focal_length_s
  end

  test 'exposure_time_s' do
    assert_equal '1/1600s', @picture.exposure_time_s
  end

  test 'iso_s' do
    assert_equal 'ISO200', @picture.iso_s
  end
end
