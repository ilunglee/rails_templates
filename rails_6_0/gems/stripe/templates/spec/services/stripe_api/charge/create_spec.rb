require 'rails_helper'

RSpec.describe StripeAPI::Charge::Create do
  let(:customer) { Stripe::Customer.create(email: 'test@email.com') }
  let(:card)     { customer.sources.create(source: 'tok_visa') }

  describe 'Call', vcr: true do
    it 'returns success' do
      charge =
        described_class.call(customer_id: customer.id,
                            card_id: card.id, amount: 1, currency: 'cad')
      expect(charge.errors.blank?).to eq(true)
    end

    it 'returns error' do
      charge =
        described_class.call(customer_id: customer.id,
                            card_id: card.id, amount: 0.5, currency: 'cad')
      expect(charge.errors[:class]).to eq('StripeAPI::Charge::Create::AmountError')
    end
  end
end
