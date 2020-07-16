# Base Stripe Source API
class StripeAPI::Source::Base < ApplicationService

  def metadata
    @metadata ||= format_metadata
  end

  private

  def format_metadata
    return {} if card.blank?

    data = card&.object.eql?('card') ? card : card&.card
    {
      card_id: card.id,
      card_last4: data&.last4,
      card_brand: data&.brand,
      card_country: data&.country
    }
  end

end
