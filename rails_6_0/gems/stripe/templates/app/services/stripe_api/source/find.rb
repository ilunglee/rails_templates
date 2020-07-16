# Find a source from Stripe customer
class StripeAPI::Source::Find < StripeAPI::Source::Base

  attr_reader :token, :customer
  attr_accessor :card

  def initialize(customer:, token:)
    @customer = customer
    @token = token
  end

  def call
    self.card = find_card
    self
  rescue Stripe::InvalidRequestError => e
    self.errors = { class: e.class.to_s, message: e.message }
    self
  end

  private

  def fingerprint
    @fingerprint ||= find_token_fingerprint
  end

  def find_token_fingerprint
    Stripe::Source.retrieve(token).try(:card).try(:fingerprint)
  rescue Stripe::InvalidRequestError => _e
    nil
  end

  def find_card
    return if fingerprint.blank?

    customer.sources.data.select do |source|
      source.object.eql?('source') && source.card.fingerprint.eql?(fingerprint)
    end.last
  end

end
