module HasAddress

  def address_arr
    line1   = format_address_line([address], delimeter: ' - ')
    line2_a = format_address_line([city, state, country])
    line2_b = format_address_line([zip_code])
    line2   = format_address_line([line2_a, line2_b], delimeter: ' ')
    [line1, line2].reject(&:blank?)
  end

  private

  def format_address_line(arr, delimeter: ', ')
    arr.reject(&:blank?).join(delimeter)
  end

end
