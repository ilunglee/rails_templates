shared_examples 'validators/zip_code_format' do |attr|
  let(:record) { build_stubbed(described_class.name.underscore) }

  it 'does not add errors with a valid zip_code' do
    %w[12345 12345-1234 12345-123456].each do |zip_code|
      record.send("#{attr}=", zip_code)
      expect(record.valid?).to eq(true)
    end
  end

  it 'adds errors with an invalid zip_code' do
    %w[1234 12345-12345 D0D0D0 invalid_zip].each do |zip_code|
      record.send("#{attr}=", zip_code)
      expect(record.valid?).to eq(false)
    end
  end
end
