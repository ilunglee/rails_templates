module HasOneUniqCode

  extend ActiveSupport::Concern

  class_methods do
    # rubocop:disable Naming/PredicateName
    def has_one_uniq_code(key, *args, &block)
      before_create -> { generate_code(key, *args, &block) }
    end
    # rubocop:enable Naming/PredicateName
  end

  private

  def generate_code(key, *args)
    options = args.extract_options!
    scope = options.delete(:scope)

    loop do
      random_code = build_code(options)
      send("#{key}=", random_code)
      break unless valid_code?(key, random_code, scope)
    end

    yield(self) if block_given?
  end

  def valid_code?(key, code, scope)
    conditions =
      if scope.present?
        ["#{key} =? AND #{scope} =?", code, try(scope)]
      else
        ["#{key} =?", code]
      end

    self.class.exists?(conditions)
  end

  def build_code(pattern: [('A'..'Z')], length: 4, prefix: nil, suffix: nil)
    pattern = pattern.map(&:to_a).flatten
    code    = (0..(length - 1)).map { pattern[rand(pattern.length)] }.join
    prefix  = prefix.is_a?(Proc) ? prefix.call(self) : prefix
    suffix  = suffix.is_a?(Proc) ? suffix.call(self) : suffix
    "#{prefix}#{code}#{suffix}"
  end

end
