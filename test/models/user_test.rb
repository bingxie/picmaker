# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  avatar                 :string
#

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
