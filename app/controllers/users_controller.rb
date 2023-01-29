class UsersController < ApplicationController

  skip_authentication only: %i[new create]

  def show
    @user = Current.user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @organization = Organization.create(members: [@user])
      @app_session = @user.app_sessions.create
      log_in(@app_session)

      redirect_to root_path, status: :see_other, flash: { success: t(".welcome", name: @user.name) }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = Current.user

    if @user.update(update_params)
      flash[:success] = t(".success")
      redirect_to profile_path, status: :see_other
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :email)
  end
end
