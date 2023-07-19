class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at

  OPTIONAL_ATTRIBUTES = {
    include_author: true,
    include_body: true,
    include_comments: true,
    include_comments_author: true,
    include_comments_body: true
  }.freeze

  # TODO: extract the following block to a module
  # BEGIN
  def initialize(object, options = {})
    super(object, options)
    @options = OPTIONAL_ATTRIBUTES.merge(options)
  end

  def method_missing(method_name, *args, &block)
    puts "method_name: #{method_name}"
    if @options.key?(method_name)
      @options[method_name]
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @options.key?(method_name) || super
  end
  # END

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

  attribute :body, if: :include_body?
  attribute :comments, if: :include_comments?
  attribute :author, if: :include_author?
end
