class UserSerializer < ActiveModel::Serializer
  attributes :id, :username

  OPTIONAL_ATTRIBUTES = {
    include_posts: true,
    include_email: true,
    include_created_at: true,
    include_updated_at: true
  }.freeze

  # TODO: extract the following block to a module
  # BEGIN
  def initialize(object, options = {})
    super(object, options)
    @options = OPTIONAL_ATTRIBUTES.merge(options)
  end

  def method_missing(method_name, *args, &block)
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

  attribute :email, if: :include_email?
  attribute :created_at, if: :include_created_at?
  attribute :updated_at, if: :include_updated_at?
  attribute :posts, if: :include_posts?
end
