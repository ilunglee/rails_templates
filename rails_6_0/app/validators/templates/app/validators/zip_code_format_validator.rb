# ZipCode Format Regex Validator
class ZipCodeFormatValidator < ActiveModel::EachValidator

  REGEX = /\A\d{5}([ \-](?:\d{4}|\d{6}))?\z/.freeze

  def validate_each(object, attribute, value)
    unless value.blank? || value =~ REGEX
      object.errors[attribute] << (
        options[:message] || I18n.t('activerecord.errors.zip_code.format')
      )
    end
    object.errors
  end

end
