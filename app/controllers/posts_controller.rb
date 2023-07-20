class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  # GET /posts (list all posts)
  def index
    @posts = Post.all
    render json: @posts, each_serializer: PostSerializer
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

    render json: @post, serializer: PostSerializer
  end

  # GET /posts/random (get a random post)
  def random
    @post = Post.order('RANDOM()').first

    if @post.nil?
      render json: { error: 'No posts present' }, status: :not_found
    else
      render json: @post
    end
  end

  # POST /posts (create a new post)
  def create
    unless current_user.admin?
      render json: { error: 'You are not authorized to create a post' }, status: :unauthorized
      return
    end

    @post = Post.new(post_params)
    @post.author = User.first

    if @post.save
      render json: @post, status: :created, location: post_url(@post)
    else
      render json: { error: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
