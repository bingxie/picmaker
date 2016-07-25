require 'test_helper'

class PictureControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_picture_path
    assert_response :success
  end
end
