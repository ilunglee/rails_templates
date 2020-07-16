module FormatHelper

  DATETIME_FORMAT = '%m/%d/%Y %I:%M%p'.freeze

  def format_datetime(date, format: DATETIME_FORMAT)
    return if date.blank?

    date.strftime(format)
  end

  def format_phone(phone)
    return if phone.blank?

    number_to_phone(phone, delimiter: '.')
  end

  def format_percentage(attr)
    number_to_percentage(attr, precision: 2, strip_insignificant_zeros: true)
  end

  def format_currency(attr, unit: '$')
    number = number_to_currency(attr, precision: 2, strip_insignificant_zeros: false, unit: unit)
    return if number.blank?

    numbers = number.split('.')
    numbers.last.to_i.zero? ? numbers.first : number
  end

  def format_card_last4(card_last4)
    return if card_last4.blank?

    arr = Array.new(1) { '****' }
    arr.push card_last4
    arr.join(' ')
  end

end
