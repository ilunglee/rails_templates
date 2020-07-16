module HasPhoneNumber

  extend ActiveSupport::Concern

  class_methods do
    def phone_number_attrs
      %i[phone_country_code phone]
    end
  end

  def full_phone_number
    "#{country_code}#{phone}"
  end

  private

  def country_code
    return if phone_country_code.blank?

    ISO3166::Country(phone_country_code)&.country_code
  end

end
