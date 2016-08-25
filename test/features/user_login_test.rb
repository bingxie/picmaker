require 'test_helper'

class UserLoginTest < FeatureTest
  test 'user can login in with email and password' do
    user = users(:one)

    visit new_user_session_path
    assert_content '登录社区'

    assert_content '还没有账号？点此加入'
    assert find_link('点此加入')

    assert find_link('忘记密码？')

    within '#new_user' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: '12345678'

      click_button '登录'
    end

    assert_content user.username
    assert_equal root_path, current_path
  end

  test 'user can not login with wrong email' do
    # test danger flash
    # test flash message

    # test with wrong password???
  end
end
