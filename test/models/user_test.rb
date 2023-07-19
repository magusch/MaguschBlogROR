require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should be valid with valid attributes' do
    user = User.new(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    assert user.valid?
  end

  test 'should not be valid without an email' do
    user = User.new(
      email: '',
      password: 'password',
      password_confirmation: 'password'
    )
    assert_not user.valid?
  end

  test 'should not be valid without a password' do
    user = User.new(
      email: 'test@example.com',
      password: '',
      password_confirmation: ''
    )
    assert_not user.valid?
  end

  test 'should not be valid if password and confirmation do not match' do
    user = User.new(
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'mismatch'
    )
    assert_not user.valid?
  end
end
