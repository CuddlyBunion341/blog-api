class CommentsController < ApplicationController
  # POST /comments (create a new comment)
  def create
    unless current_user
      render json: { error: 'You must be logged in to comment' }, status: :unauthorized
      return
    end

    comment = Comment.new(post_params)
    comment.author = current_user

    if comment.save
      render json: comment, serializer: CommentsSerializer
    else
      render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:comment).permit(:body, :post_id)
  end
end
