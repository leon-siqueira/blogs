class AdminController < ActionController::Base
  http_basic_authenticate_with name: Rails.application.credentials.mission_control.http_basic_auth_user, password: Rails.application.credentials.mission_control.http_basic_auth_password
end
