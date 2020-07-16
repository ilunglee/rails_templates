# Phone Format
class PhoneFormatValidator < ActiveModel::EachValidator

  PHONE_NUMBER_REGEX = /^[0-9]{9,11}$/i.freeze

  def validate_each(object, attribute, value)
    unless value.blank? || value =~ PHONE_NUMBER_REGEX
      object.errors[attribute] << (
        options[:message] || I18n.t('activerecord.errors.phone.format')
      )
    end
    object.errors
  end

end
