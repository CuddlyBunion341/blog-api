class AdaptiveSerializer < ActiveModel::Serializer
  attributes :id

  def initialize(object, serializer_options = {})
    super(object, serializer_options)
    @options = serializer_options
    define_dynamic_methods
  end

  def define_dynamic_methods
    @options.each do |key, _|
      define_singleton_method("#{key}?") do
        @options[key]
      end
    end
  end
end
