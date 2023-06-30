class PostsController < ApplicationController
  # GET /posts (list all posts)
  def index
    @posts = Post.all
    render json: @posts
  end

  # GET /posts/:id (get a specific post)
  def show
    # TODO: refactor this to a before_action
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
      return
    end

    render json: @post
  end

  # GET /posts/random (get a random post)
  def random
    @post = Post.order('RANDOM()').first
    render json: @post
  end
end
