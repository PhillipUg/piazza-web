class Users::PasswordsController < ApplicationController
  before_action :authenticate_current_password

  def update
    @user.password = params.dig(:user, :password)

    if @user.save(context: :password_change)
      flash[:success] = t(".success")
      redirect_to profile_path, status: :see_other
    else
      render "users/show", status: :unprocessable_entity
    end
  end

  private

  def authenticate_current_password
    @user = Current.user
    current_password = params.dig(:user, :current_password)

    unless @user.authenticate(current_password)
      flash.now[:danger] = t(".incorrect_password")
      render "users/show", status: :unprocessable_entity
    end
  end
end
