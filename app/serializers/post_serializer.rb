class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :author, :comments

  def author
    {
      id: object.user.id,
      username: object.user.username
    }
  end

  def comments
    object.comments.map do |comment|
      {
        id: comment.id,
        body: comment.body,
        created_at: comment.created_at,
        updated_at: comment.updated_at,
        author: {
          id: comment.author.id,
          username: comment.author.username
        }
      }
    end
  end
end
