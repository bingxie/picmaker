require 'test_helper'

class PictureControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get picture_new_url
    assert_response :success
  end

  test "should get create" do
    get picture_create_url
    assert_response :success
  end

  test "should get show" do
    get picture_show_url
    assert_response :success
  end

end
