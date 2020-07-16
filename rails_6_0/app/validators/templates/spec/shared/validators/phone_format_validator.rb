shared_examples 'validators/phone_format' do |attr|
  let(:record) { build_stubbed(described_class.name.underscore) }

  it 'returns invalid for phone format— #### ####' do
    record.send("#{attr}=", '12345678')
    expect(record.valid?).to eq(false)
  end

  it 'returns valid for phone format— #### #### #' do
    record.send("#{attr}=", '123456789')
    expect(record.valid?).to eq(true)
  end

  it 'returns valid for phone format— #### #### #### ##' do
    record.send("#{attr}=", '1234567890')
    expect(record.valid?).to eq(true)
  end

  it 'returns valid for phone format- #### #### #### ###' do
    record.send("#{attr}=", '12345678901')
    expect(record.valid?).to eq(true)
  end

  it 'returns invalid for phone format— #### #### #### ####' do
    record.send("#{attr}=", '123456789012')
    expect(record.valid?).to eq(false)
  end
end
