require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  include ActionDispatch::TestProcess
  include Devise::Test::IntegrationHelpers

  test '#new' do
    get root_url
    assert_response :success

    assert_includes response.body, '分享照片'
  end

  test '#index' do
    sign_in users(:one)

    get pictures_path

    assert_response :success
    assert_includes response.body, '退出'
  end

  test 'create picture' do
    file = fixture_file_upload('files/DSC_3264.JPG', 'image/jpg')

    assert_difference 'Picture.count' do
      post_picture(file)
    end

    assert_response :success
    assert_equal 'application/json', response.content_type
    picture = response.parsed_body

    assert_equal 'black', picture['border_style']
    assert_equal '35mm f/1.8', picture['lens']
    assert_equal 'NIKON D7000', picture['model']
    assert_equal 'AF-S DX Nikkor 35mm f/1.8G', picture['lens_id']
    assert_equal '2.8', picture['f_number']
    assert_equal '35.0 mm', picture['focal_length']
    assert_equal '1/320', picture['exposure_time']
    assert_equal '200', picture['iso']
  end

  test 'can not upload png file' do
    file = fixture_file_upload('files/PNG_TEST.png', 'image/png')
    assert_no_difference 'Picture.count' do
      post_picture(file)
    end

    assert_response :unprocessable_entity
    assert_includes response.parsed_body['file_name'],
                    I18n.t('errors.messages.extension_white_list_error')
  end

  class RoutesTest < ActionDispatch::IntegrationTest
    def test_routes
      assert_routing({ method: 'post', path: '/pictures' }, controller: 'pictures', action: 'create')

      assert_recognizes({ controller: 'pictures', action: 'border' }, '/')
    end
  end

  private

  def post_picture(file)
    post '/pictures', params: { picture: { border_style: 'black',
                                           file_name: file } },
                      xhr: true
  end
end
