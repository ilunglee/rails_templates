require 'rails_helper'

RSpec.describe StripeAPI::Customer::Find do
  let(:customer) { Stripe::Customer.create(email: 'test@email.com') }

  describe 'Call', vcr: true do
    it 'returns success' do
      service = described_class.call(customer.id)
      expect(service.errors.present?).to eq(false)
    end

    it 'returns error' do
      service = described_class.call('123')
      expect(service.errors[:class]).to eq('Stripe::InvalidRequestError')
    end
  end
end
