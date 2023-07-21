class ApplicationController < ActionController::API
  respond_to :json

  protected

  def authenticate_user!
    return if user_signed_in?

    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username password_confirmation])
  end
end
