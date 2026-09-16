class UserController < ApplicationController
  before_action :set_user

  def index
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "Information update successfully"
    else
      flash[:alert] = "Could not update information"
      render :edit, status: :unprocessable_content
    end
  end

  def edit_password
  end

  def update_password
    if @user.update_with_password(user_password_params)
      bypass_sign_in(@user)
      redirect_to user_path, notice: "Password updated successfully"
    else
      flash[:alert] = "Could not update password"
      render :edit_password, status: :unprocessable_content
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.fetch(:user, {}).permit(:name)
  end

  def user_password_params
    params.fetch(:user, {}).permit(:current_password, :password, :password_confirmation)
  end
end
