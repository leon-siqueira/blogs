class UsersController < ApplicationController
  before_action :set_user_as_current, only: [ :profile, :edit_profile, :update, :destroy ]
  allow_unauthenticated_access only: %i[ new create ]

  def profile
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User was successfully created."
      redirect_to @user
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("user_form", partial: "users/form", locals: { user: @user, usage: :register }) }
      end
    end
  end

  def edit_profile
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User was successfully updated."
      redirect_to @user
    else
      flash[:alert] =  "Could not update the user."
      render :edit_profile
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User was successfully destroyed."
      redirect_to root_path
    else
      flash[:alert] =  "Could not delete the user."
      redirect_to profile_path
    end
  end

  private

    def set_user_as_current
      @user = Current.user
    end

    def user_params
      params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
    end
end
