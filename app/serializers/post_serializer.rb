class PostSerializer < AdaptiveSerializer
  attributes :id, :title, :created_at, :updated_at

  OPTIONAL_ATTRIBUTES = {
    include_author: true,
    include_body: true,
    include_comments: true,
    include_comments_author: true,
    include_comments_body: true
  }.freeze

  def initialize(object, options = {})
    super(object, OPTIONAL_ATTRIBUTES.merge(options))
  end

  def author
    user_options = {
      include_posts: false,
      include_email: false,
      include_created_at: false,
      include_updated_at: false
    }

    UserSerializer.new(object.author, user_options)
  end

  def comments
    comment_options = {
      include_author: include_comments_author?,
      include_body: include_comments_body?
    }

    object.comments.map do |comment|
      CommentsSerializer.new(comment, comment_options)
    end
  end

  attribute :body, if: :include_body?
  attribute :comments, if: :include_comments?
  attribute :author, if: :include_author?
end
