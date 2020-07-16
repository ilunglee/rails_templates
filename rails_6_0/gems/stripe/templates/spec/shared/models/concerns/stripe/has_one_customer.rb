shared_examples_for 'models/concerns/stripe/has_one_customer' do
  let(:record) { build_stubbed(described_class.name.underscore) }
  let(:service) { instance_double(StripeCustomerAssociator) }

  before do
    allow(record).to receive(:associate_stripe_customer).and_return(true)
    allow(service).to receive(:call).and_return(true)
  end

  describe 'Validations' do
    it 'validates stripe_token if new_card is true' do
      record.new_card = true
      expect(record).to validate_presence_of(:stripe_token)
    end
  end

  describe 'Callbacks' do
    it 'resets stripe_token if not new_card' do
      record.new_card = false
      record.valid?
      expect(record.stripe_token).to be_nil
    end

    it 'calls StripeCustomerAssociator on save' do
      record.run_callbacks(:save)
      expect(record).to have_received(:associate_stripe_customer)
    end
  end
end
