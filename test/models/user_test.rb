require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires a name" do
    @user = User.new(name: "", email: "johndoe@example.com", password: "password")
    assert_not @user.valid?
    @user.name = "John Doe"
    assert @user.valid?
  end

  test 'requires a valid email' do
    @user = User.new(name: "John Doe", email: "", password: "password")
    assert_not @user.valid?

    @user.email = "invalid"
    assert_not @user.valid?

    @user.email = "johndoe@example.com"
    assert @user.valid?
  end

  test 'requires a unique email' do
    @existing_user = User.create(name: "John Doe", email: "johndoe@example.com", password: "password")
    assert @existing_user.persisted?

    @user = User.new(name: "Jane Doe", email: "johndoe@example.com", password: "password")
    assert_not @user.valid?
  end

  test 'name and email are stripped of spaces before saving' do
    @user = User.create(name: " John Doe ", email: " johndoe@example.com ")
    assert_equal "John Doe", @user.name
    assert_equal "johndoe@example.com", @user.email
  end

  test 'password length must be between 8 and ActiveModels maximum' do
    @user = User.new(name: "John Doe", email: "johndoe@example.com", password: "")
    assert_not @user.valid?
    @user.password = "password"
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = "a" * (max_length + 1)
    assert_not @user.valid?
  end
end
