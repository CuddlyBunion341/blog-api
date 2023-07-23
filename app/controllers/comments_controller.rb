class CommentsController < ApplicationController
  # POST /comments (create a new comment)
  def create
    unless current_user
      render json: { error: 'You must be logged in to comment' }, status: :unauthorized
      return
    end

    comment = Comment.new(post_params)
    comment.user = current_user
    comment.save

    render json: comment, serializer: CommentSerializer
  end

  def post_params
    params.require(:comment).permit(:body, :post_id)
  end
end
