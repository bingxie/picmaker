require 'test_helper'

class PicturesControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    get root_url
    assert_response :success

    assert_includes @response.body, '照片信息变水印神器'
  end

  class RoutesTest < PicturesControllerTest
    def test_routes
      assert_routing({ method: 'post', path: '/pictures' }, controller: 'pictures', action: 'create')

      assert_recognizes({ controller: 'pictures', action: 'index' }, '/')
    end
  end
end
