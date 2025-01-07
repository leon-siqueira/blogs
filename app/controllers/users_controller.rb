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
      flash[:success] = I18n.t("flash_alerts.users.create.success")
      redirect_to new_session_path
    else
      flash[:alert] = I18n.t("flash_alerts.users.create.error")
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
      flash[:success] = I18n.t("flash_alerts.users.update.success")
      redirect_to @user, id: @user.id
    else
      flash[:alert] = I18n.t("flash_alerts.users.update.error")
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("user_form", partial: "users/form", locals: { user: @user, usage: :edit }) }
      end
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = I18n.t("flash_alerts.users.destroy.success")
      redirect_to root_path
    else
      flash[:alert] = I18n.t("flash_alerts.users.destroy.error")
      redirect_to profile_path
    end
  end

  private

    def set_user_as_current
      @user = Current.user
    end

    def user_params
      params.require(:user).reject { |_, v| v.blank? }
      if params[:user][:password].present? && params[:user][:password_confirmation].nil?
        params[:user][:password_confirmation] = ""
      end
      params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
    end
end
