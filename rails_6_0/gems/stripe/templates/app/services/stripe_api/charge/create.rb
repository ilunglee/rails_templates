# Charge Stripe customer
class StripeAPI::Charge::Create

  MIN_AMOUNT = 0.50

  class AmountError < StandardError; end
  class TokenError < StandardError; end
  extend Callable

  attr_reader :customer_id, :card_id, :amount, :description, :metadata, :currency
  attr_accessor :charge, :errors

  def initialize(customer_id:, amount:, currency:, card_id: nil, options: {})
    @customer_id = customer_id
    @card_id     = card_id
    @amount      = amount
    @currency    = currency
    @description = options[:description]
    @metadata    = options[:metadata]
  end

  def call
    raise(AmountError, amount_error) if insufficient_amount?

    self.charge = charge_customer
    self
  rescue Stripe::CardError, Stripe::InvalidRequestError, TokenError, AmountError => e
    self.errors = { class: e.class.to_s, message: e.message }
    self
  end

  def card_metadata
    @card_metadata ||= format_card_metadata
  end

  private

  def charge_customer
    Stripe::Charge.create(
      customer: customer_id, source: card_id, amount: (amount * 100).to_i,
      metadata: metadata, description: description, currency: currency,
      statement_descriptor: Rails.configuration.stripe[:statement_descriptor]
    )
  end

  def format_card_metadata
    return {} if charge.blank?

    source = charge.source
    card = source&.object.eql?('card') ? source : source&.card
    {
      card_id: source.id,
      card_last4: card&.last4,
      card_brand: card&.brand,
      card_country: card&.country
    }
  end

  def insufficient_amount?
    amount <= MIN_AMOUNT
  end

  def amount_error
    I18n.t(:amount, scope: %i[services errors stripe_api charge create])
  end

  def token_error
    I18n.t(:token, scope: %i[services errors stripe_api charge create])
  end

end
