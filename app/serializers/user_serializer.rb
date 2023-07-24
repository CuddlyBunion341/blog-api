class UserSerializer < AdaptiveSerializer
  attributes :id, :username

  OPTIONAL_ATTRIBUTES = {
    include_comments: true,
    include_posts: true,
    include_email: true,
    include_created_at: true,
    include_updated_at: true
  }.freeze

  def initialize(object, options = {})
    super(object, OPTIONAL_ATTRIBUTES.merge(options))
  end

  def posts
    post_options = {
      include_author: false,
      include_body: false,
      include_comments: false,
      include_comments_author: false,
      include_comments_body: false
    }

    object.posts.map do |post|
      PostSerializer.new(post, post_options)
    end
  end

  def comments
    comment_options = {
      include_author: false,
      include_body: true,
      include_post: true,
      include_post_author: false,
      include_post_body: false
    }

    object.comments.map do |comment|
      CommentsSerializer.new(comment, comment_options)
    end
  end

  attribute :email, if: :include_email?
  attribute :created_at, if: :include_created_at?
  attribute :updated_at, if: :include_updated_at?
  attribute :posts, if: :include_posts?
  attribute :comments, if: :include_comments?
end
