class UsersController < ApplicationController
  # GET /users (list all users)
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/:id (get a specific user)
  def show
    # TODO: refactor this to a before_action
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
      return
    end

    if params[:expand] == 'posts'
      render json: @user, include: :posts
    else
      render json: @user
    end
  end
end
