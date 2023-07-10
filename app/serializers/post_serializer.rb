class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :author

  def author
    {
      id: object.user.id,
      username: object.user.username
    }
  end
end
