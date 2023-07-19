class CommentsSerializer < ActiveModel::Serializer
  attributes :id

  def initialize(object, options = {})
    super(object, options)
    @include_author = options[:include_author].nil? ? true : options[:include_author]
    @include_created_at = options[:include_created_at].nil? ? true : options[:include_created_at]
    @include_updated_at = options[:include_updated_at].nil? ? true : options[:include_updated_at]
    @include_body = options[:include_body].nil? ? true : options[:include_body]

    puts options
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

  def include_body?
    @include_body
  end

  def include_author?
    @include_author
  end

  def include_created_at?
    @include_created_at
  end

  def include_updated_at?
    @include_updated_at
  end

  attribute :body, if: :include_body?
  attribute :author, if: :include_author?
  attribute :created_at, if: :include_created_at?
  attribute :updated_at, if: :include_updated_at?
end
