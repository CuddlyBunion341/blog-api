class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at

  def initialize(object, options = {})
    super(object, options)
    @include_author = options[:include_author].nil? ? true : options[:include_author]
    @include_body = options[:include_body].nil? ? true : options[:include_body]
    @include_comments = options[:include_comments].nil? ? true : options[:include_comments]
    @include_comments_author = options[:include_comments_author].nil? ? true : options[:include_comments_author]
    @include_comments_body = options[:include_comments_body].nil? ? true : options[:include_comments_body]
  end

  def author
    user_options = {
      include_posts: false,
      include_email: true,
      include_created_at: true,
      include_updated_at: true
    }

    UserSerializer.new(object.author, user_options)
  end

  def comments
    comment_options = {
      include_author: @include_comments_author,
      include_body: @include_comments_body
    }

    object.comments.map do |comment|
      CommentsSerializer.new(comment, comment_options)
    end
  end

  def include_body?
    @include_body
  end

  def include_comments?
    @include_comments
  end

  def include_author?
    @include_author
  end

  attribute :body, if: :include_body?
  attribute :comments, if: :include_comments?
  attribute :author, if: :include_author?
end
