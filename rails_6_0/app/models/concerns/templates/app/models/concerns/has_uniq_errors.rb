module HasUniqErrors

  def uniq_errors(attrs = [])
    errors.collect do |attr, msg|
      next unless errors[attr].first == msg && (attrs.include?(attr) || attrs.blank?)

      I18n.t(i18n_error_scope(attr), default: errors.full_messages_for(attr).first)
    end.reject(&:blank?)
  end

  private

  def i18n_error_scope(attr)
    key        = attr.to_s.tr('.', '/')
    full_scope = "activerecord.errors.models.#{underscore_name}.#{key}"
    if I18n.exists? full_scope
      full_scope
    else
      "activerecord.errors.models.#{underscore_name.split('/').first.singularize}.#{attr}"
    end
  end

  def underscore_name
    model_name.name.underscore
  end

end
