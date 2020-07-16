require 'rails_helper'

RSpec.describe StripeAPI::Customer::Create do
  describe 'Call', vcr: true do
    it 'returns success' do
      service = described_class.call('test@email.com')
      expect(service.errors.present?).to eq(false)
    end

    it 'returns error' do
      service = described_class.call('')
      expect(service.errors[:class]).to eq('StripeAPI::Customer::Create::MissingRequiredKeysError')
    end
  end
end
