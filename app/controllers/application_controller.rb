class ApplicationController < ActionController::API
  def current_user
    return nil unless session[:user_id]

    User.find_by(id: session[:user_id])
  end
end
