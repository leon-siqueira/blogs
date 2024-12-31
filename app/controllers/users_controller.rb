class UsersController < ApplicationController
  before_action :set_user_as_current, only: [ :profile, :edit_profile, :update, :destroy ]

  def profile
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
    end
  end

  def edit_profile
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit_profile
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_url, notice: "User was successfully destroyed."
  end

  private

    def set_user_as_current
      @user = Current.user
    end

    def user_params
      params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
    end
end
