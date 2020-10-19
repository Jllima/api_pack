RSpec.describe ApiPack do
  it 'has a version number' do
    expect(ApiPack::VERSION).not_to be nil
  end

  it 'has a ex default' do
    expect(ApiPack.exp).to be_a Integer
  end

  it 'Serializer adapater default is Fast Json Api' do
    expect(ApiPack.serializer_adapter=(:fast_json_api)).to eq :fast_json_api
  end
end
