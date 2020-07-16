# Create a source for Stripe customer
class StripeAPI::Source::Create < StripeAPI::Source::Base

  attr_reader :token, :customer
  attr_accessor :card

  def initialize(customer:, token:)
    @customer = customer
    @token = token
  end

  def call
    self.card = customer.sources.create(source: token)
    self
  rescue Stripe::InvalidRequestError => e
    self.errors = { class: e.class.to_s, message: e.message }
    self
  end

end
