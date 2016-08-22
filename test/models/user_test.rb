require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username)
  should validate_length_of(:username).is_at_least(3).is_at_most(20)

  test '#admin?' do
    admin = users(:admin)

    assert admin.admin?

    user = User.new
    assert_not user.admin?

    user = User.new(role: 'manager')
    assert_not user.admin?
  end
end
