class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_now
    end

    flash[:success] = I18n.t("flash_alerts.passwords.create.success")
    redirect_to new_session_path
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      flash[:success] = I18n.t("flash_alerts.passwords.update.success")
      redirect_to new_session_path
    else
      flash[:alert] = I18n.t("flash_alerts.passwords.update.error")
      redirect_to edit_password_path(token: params[:token])
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      flash[:alert] = I18n.t("flash_alerts.passwords.token_error")
      redirect_to new_password_path
    end
end
