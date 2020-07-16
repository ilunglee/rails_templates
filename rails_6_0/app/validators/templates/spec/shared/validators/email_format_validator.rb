shared_examples 'validators/email_format' do |attr|
  let(:record) { build_stubbed(described_class.name.underscore) }

  it 'returns invalid for email format— ####' do
    record.send("#{attr}=", 'abcd')
    expect(record.valid?).to eq(false)
  end

  it 'returns invalid for email format— ####@##' do
    record.send("#{attr}=", 'abcd@as')
    expect(record.valid?).to eq(false)
  end

  it 'returns invalid for email format— ####.##' do
    record.send("#{attr}=", 'abcd.com')
    expect(record.valid?).to eq(false)
  end
end
