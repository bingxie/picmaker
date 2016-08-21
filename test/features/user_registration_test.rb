require 'test_helper'

class UserRegistrationTest < FeatureTest
  setup do
    ActionMailer::Base.deliveries.clear
  end

  test 'user signs up with email and password' do
    visit new_user_registration_path

    assert_content '注册成为新用户'

    within '#new_user' do
      fill_in 'user[email]', with: 'test_user@gmail.com'
      fill_in 'user[username]', with: 'my_username'
      fill_in 'user[password]', with: 'abcd1234'

      click_button '注册'
    end

    assert_equal '/', page.current_path

    test_confirm_email
  end

  private

  def test_confirm_email
    assert_not ActionMailer::Base.deliveries.empty?

    cf_email = ActionMailer::Base.deliveries.last

    assert_equal ['test@example.com'], cf_email.from
    assert_equal ['test_user@gmail.com'], cf_email.to
    assert_equal '确认信息', cf_email.subject
    assert cf_email.body.to_s.include? 'Confirm my account'
  end
end
