class Users::SessionsController < ApplicationController
  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, serializer: UserSerializer, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # DELETE /logout
  def logout
    if current_user.nil?
      render json: { error: 'Not logged in' }, status: :unauthorized
      return
    end

    session.delete(:user_id)
    render json: { message: 'Logged out' }, status: :ok
  end

  # GET /user
  def user
    if current_user.nil?
      render json: { error: 'Not logged in' }, status: :unauthorized
      return
    end

    render json: current_user, serializer: UserSerializer, status: :ok
  end
end
