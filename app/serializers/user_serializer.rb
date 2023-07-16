class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :created_at, :updated_at

  def posts
    object.posts.map do |post|
      {
        id: post.id,
        title: post.title,
        created_at: post.created_at,
        updated_at: post.updated_at
      }
    end
  end
end
