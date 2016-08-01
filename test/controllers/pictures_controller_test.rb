require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  include ActionDispatch::TestProcess

  test '#index' do
    get root_url
    assert_response :success

    assert_includes @response.body, '照片信息变水印神器'
  end

  test '#creaet' do
    file = fixture_file_upload('files/DSC_3264.JPG', 'image/jpg')
    post '/pictures', params: { picture: { border_style: 'black',
                                           file_name: file } },
                      xhr: true

    assert_response :success

    picture = JSON.parse(@response.body)

    assert_equal 'black', picture['border_style']
    assert_equal '35mm f/1.8', picture['lens']
  end

  class RoutesTest < ActionDispatch::IntegrationTest
    def test_routes
      assert_routing({ method: 'post', path: '/pictures' }, controller: 'pictures', action: 'create')

      assert_recognizes({ controller: 'pictures', action: 'index' }, '/')
    end
  end
end
