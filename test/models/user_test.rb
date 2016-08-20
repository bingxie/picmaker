require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#admin?' do
    admin = users(:admin)

    assert admin.admin?

    user = User.new()
    assert_not user.admin?

    user = User.new(role: 'manager')
    assert_not user.admin?
  end
end
