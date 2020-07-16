# Creates Stripe customer
class StripeAPI::Customer::Create < ApplicationService

  class MissingRequiredKeysError < StandardError; end

  attr_reader :email
  attr_accessor :customer

  def initialize(email)
    @email = email
  end

  def call
    raise(MissingRequiredKeysError, required_keys_error) if email.blank?

    self.customer = create_customer
    self
  rescue Stripe::InvalidRequestError, MissingRequiredKeysError => e
    self.errors = { class: e.class.to_s, message: e.message }
    self
  end

  private

  def create_customer
    Stripe::Customer.create(email: email)
  end

  def required_keys_error
    I18n.t(:required_keys, scope: %i[services errors stripe_api customer create])
  end

end
