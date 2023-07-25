class UsersController < ApplicationController
  before_action :require_user, only: %i[show]

  # GET /users (list all users)
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/:id (get a specific user)
  def show
    if params[:expand] == 'posts'
      render json: @user, include: :posts
    else
      render json: @user
    end
  end

  # GET /users/current (get the current user)
  def current
    @user = current_user
    if @user
      render json: @user, serializer: UserSerializer, include_posts: false
    else
      render json: { error: 'Not logged in' }, status: :unauthorized
    end
  end

  private

  def require_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end
end
