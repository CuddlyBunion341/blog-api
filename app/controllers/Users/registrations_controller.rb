class Users::RegistrationsController < ApplicationController
  # POST /signup
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: user, serializer: UserSerializer, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
