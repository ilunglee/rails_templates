# Find Stripe customer
class StripeAPI::Customer::Find < ApplicationService

  attr_reader :id
  attr_accessor :customer

  def initialize(id)
    @id = id
  end

  def call
    self.customer = find_customer
    self
  rescue Stripe::InvalidRequestError => e
    self.errors = { class: e.class.to_s, message: e.message }
    self
  end

  private

  def find_customer
    req = Stripe::Customer.retrieve(id)
    req.try(:deleted?) ? nil : req
  end

end
