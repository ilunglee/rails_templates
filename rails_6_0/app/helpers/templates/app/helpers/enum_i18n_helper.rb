module EnumI18nHelper

  def enum_i18n_options(class_name, enum, use_value: false)
    class_name.send(enum.to_s.pluralize).map do |key, value|
      val = use_value ? value : key
      [enum_i18n(class_name, enum, key), val]
    end
  end

  def enum_i18n(class_name, enum, key)
    return if key.blank?

    I18n.t('activerecord.attributes.' \
           "#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}/#{key}", default: key.humanize)
  end

end
