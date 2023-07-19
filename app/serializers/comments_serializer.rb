class CommentsSerializer < ActiveModel::Serializer
  attributes :id

  OPTIONAL_ATTRIBUTES = {
    include_author: true,
    include_created_at: true,
    include_updated_at: true,
    include_body: true
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

  def author
    user_options = {
      include_posts: false,
      include_email: false,
      include_created_at: false,
      include_updated_at: false
    }

    UserSerializer.new(object.author, user_options)
  end

  attribute :body, if: :include_body?
  attribute :author, if: :include_author?
  attribute :created_at, if: :include_created_at?
  attribute :updated_at, if: :include_updated_at?
end
