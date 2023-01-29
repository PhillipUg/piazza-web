require "test_helper"

class Users::PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    log_in(@user)
  end

  test "can change password" do
    patch users_change_password_path, params: {
      user: {
        current_password: "password",
        password: "new password",
        password_confirmation: "new password"
      }
    }

    assert_redirected_to profile_path
    assert @user.reload.authenticate("new password")
  end

  test "error response if current password is incorrect" do
    patch users_change_password_path, params: {
      user: {
        current_password: "wrong password",
        password: "new password",
        password_confirmation: "new password"
      }
    }

    assert_response :unprocessable_entity
    assert_not @user.reload.authenticate("new password")
  end

  test "error response if new password is invalid" do
    patch users_change_password_path, params: {
      user: {
        current_password: "password",
        password: "invalid",
        password_confirmation: "invalid"
      }
    }

    assert_response :unprocessable_entity
  end
end
