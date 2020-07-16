# Associate resource with Stripe customer
class StripeCustomerAssociator < ApplicationService

  CustomerError = Class.new StandardError
  CardError = Class.new StandardError

  attr_reader :id, :email, :token
  attr_accessor :metadata, :customer, :card

  def initialize(id:, email:, token:)
    @id = id
    @email = email
    @token = token
    @metadata = {}
  end

  def call
    find_or_create_customer
    find_or_create_card if token.present?
    self
  rescue CustomerError, CardError => e
    self.errors = { class: e.class.to_s, message: e.message }
    self
  end

  private

  def find_or_create_customer
    self.customer = customer_service.customer
    self.metadata = metadata.merge(customer_id: customer.id, token: token)
    return if customer_service.errors.blank?

    raise CustomerError, customer_service.errors[:message]
  end

  def find_or_create_card
    self.card = source_service.card
    self.metadata = metadata.merge(source_service.metadata)
    return if source_service.errors.blank?

    raise CardError, source_service.errors[:message]
  end

  def customer_service
    @customer_service ||=
      StripeAPI::Customer::FindOrCreate.call(id: id, email: email)
  end

  def source_service
    @source_service ||=
      StripeAPI::Source::FindOrCreate.call(customer: customer, token: token)
  end

end
