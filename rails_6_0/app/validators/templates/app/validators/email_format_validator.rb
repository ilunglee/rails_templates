# Email Format Regex Validator
class EmailFormatValidator < ActiveModel::EachValidator

  EMAIL_REGEX = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,8}$/i.freeze

  def validate_each(object, attribute, value)
    unless value.blank? || value =~ EMAIL_REGEX
      object.errors[attribute] << (
        options[:message] || I18n.t('activerecord.errors.email.format')
      )
    end
    object.errors
  end

end
