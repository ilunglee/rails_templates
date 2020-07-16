# Find or create a source for Stripe customer
class StripeAPI::Source::FindOrCreate < StripeAPI::Source::Base

  attr_reader :token, :customer, :replace
  attr_accessor :card, :service

  def initialize(customer:, token:, replace: true)
    @customer = customer
    @token = token
    @replace = replace
  end

  def call
    self.card = existing_card || create_new_card
    replace_card
    self.errors = service.errors
    self
  end

  def new_record?
    existing_card.blank?
  end

  private

  def replace_card
    return unless card.present? && replace

    customer.default_source = card.id
    customer.save
  end

  def existing_card
    @existing_card ||= find_card
  end

  def find_card
    self.service = StripeAPI::Source::Find.call(customer: customer, token: token)
    service.errors.present? ? nil : service.card
  end

  def create_new_card
    self.service = StripeAPI::Source::Create.call(customer: customer, token: token)
    service.card
  end

end
