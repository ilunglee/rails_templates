module HasPersonName

  extend ActiveSupport::Concern

  class_methods do
    def person_name_attrs
      %i[first_name last_name]
    end
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def display_name
    full_name.presence || email
  end

  def initial
    display_name.first&.upcase
  end

end
