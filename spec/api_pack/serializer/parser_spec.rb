RSpec.describe ApiPack::Serializer::Parser do
  describe '.adapter' do
    context 'set :fast_json_api' do
      before do
        described_class.adapter = :fast_json_api
      end

      it { expect(described_class.adapter).to eq ApiPack::Serializer::Adapter::FastJsonApi }
    end

    context 'default value' do
      it { expect(described_class.adapter).to eq ApiPack::Serializer::Adapter::FastJsonApi }
    end
  end
end
