require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get new_uploads' do
    # get home_new_url
    # assert_response :success
  end

  test 'should get collections' do
    get home_collections_url
    assert_response :success
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end
end
