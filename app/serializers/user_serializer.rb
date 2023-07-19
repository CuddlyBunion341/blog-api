class UserSerializer < ActiveModel::Serializer
  attributes :id, :username

  def initialize(object, options = {})
    super(object, options)
    @include_posts = options[:include_posts].nil? ? false : options[:include_posts]
    @include_email = options[:include_email].nil? ? false : options[:include_email]
    @include_created_at = options[:include_created_at].nil? ? true : options[:include_created_at]
    @include_updated_at = options[:include_updated_at].nil? ? true : options[:include_updated_at]
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

  def include_email?
    @include_email
  end

  def include_created_at?
    @include_created_at
  end

  def include_updated_at?
    @include_updated_at
  end

  def include_posts?
    @include_posts
  end

  attribute :email, if: :include_email?
  attribute :created_at, if: :include_created_at?
  attribute :updated_at, if: :include_updated_at?
  attribute :posts, if: :include_posts?
end
