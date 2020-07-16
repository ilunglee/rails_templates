require 'rails_helper'

RSpec.describe StripeAPI::Source::Find do
  let(:customer) { Stripe::Customer.create(email: 'test@email.com') }

  describe 'Call', vcr: true do
    pending "need to fix this spec #{__FILE__}"

    it 'returns error' do
      service = described_class.call(customer: customer, token: 'invalid_token')
      expect(service.card).to eq(nil)
    end
  end
end
