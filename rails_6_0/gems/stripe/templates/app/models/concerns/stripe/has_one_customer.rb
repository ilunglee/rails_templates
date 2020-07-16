module Stripe::HasOneCustomer

  extend ActiveSupport::Concern

  included do
    attribute :new_card, :boolean, default: false
    store_accessor :stripe_obj,
                  %i[customer_id token card_id card_last4 card_country card_brand],
                  prefix: 'stripe'

    before_validation :reset_stripe_token, unless: :new_card?, on: :update
    validates :stripe_token, presence: true, if: :new_card?
    before_save :associate_stripe_customer
  end

  class_methods do
    def stripe_attrs
      %i[stripe_token new_card]
    end
  end

  private

  def reset_stripe_token
    self.stripe_token = nil
  end

  def associate_stripe_customer
    service =
      StripeCustomerAssociator.call(id: stripe_customer_id, email: email, token: stripe_token)
    assign_stripe_attrs(service.metadata)
    return if service.errors.blank?

    error.add :base, service.errors[:message]
    raise ActiveRecord::RecordInvalid
  end

  def assign_stripe_attrs(metadata)
    assign_attributes(stripe_obj: stripe_obj.merge(metadata))
  end

end
