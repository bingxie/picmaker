require 'test_helper'

class PictureControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get pictures_path
    assert_response :success
  end
end
