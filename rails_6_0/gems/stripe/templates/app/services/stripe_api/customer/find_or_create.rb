# Find or create a Stripe customer
class StripeAPI::Customer::FindOrCreate < ApplicationService

  attr_reader :email, :id
  attr_accessor :customer, :service

  def initialize(email:, id: nil)
    @email = email
    @id = id
  end

  def call
    self.customer = existing_customer || create_customer
    self.errors = service.errors
    self
  end

  def new_record?
    existing_customer.blank?
  end

  private

  def existing_customer
    @existing_customer ||= find_customer
  end

  def create_customer
    self.service = StripeAPI::Customer::Create.call(email)
    service.customer
  end

  def find_customer
    return if id.blank?

    self.service = StripeAPI::Customer::Find.call(id)
    service.errors.present? ? nil : service.customer
  end

end
