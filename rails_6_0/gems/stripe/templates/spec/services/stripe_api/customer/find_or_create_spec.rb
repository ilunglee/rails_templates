require 'rails_helper'

RSpec.describe StripeAPI::Customer::FindOrCreate do
  let(:struct) { Struct.new(:customer, :errors) }

  before do
    allow(StripeAPI::Customer::Create).
      to receive(:call).with('fake_email').and_return(struct.new('create', nil))
  end

  describe 'Call' do
    it 'finds customer' do
      allow(StripeAPI::Customer::Find).
        to receive(:call).with('fake_id').and_return(struct.new('find', nil))

      service = described_class.call(email: 'fake_email', id: 'fake_id')
      expect(service.customer).to eq('find')
    end

    it 'creats new customer if cannot find' do
      allow(StripeAPI::Customer::Find).
        to receive(:call).with('fake_id').and_return(struct.new('find', 'some error'))

      service = described_class.call(email: 'fake_email', id: 'fake_id')
      expect(service.customer).to eq('create')
    end
  end
end
