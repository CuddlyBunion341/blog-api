class PostsController < ApplicationController
  # GET /posts (list all posts)
  def index
    @posts = Post.all
    render json: @posts
  end
end
