RSpec.describe ApiPack do
  let(:controller) { MockController.new }

  it 'has a version number' do
    expect(ApiPack::VERSION).not_to be nil
  end

  it 'has a ex default' do
    expect(ApiPack.exp).to be_a Integer
  end

  it 'Serializer adapater default is Fast Json Api' do
    expect(ApiPack.serializer_adapter=(:fast_json_api)).to eq :fast_json_api
  end

  describe '#pagination_meta_generator(request, total_pages)' do
    let(:mock_request) do
      instance_double(
        'Request',
        base_url: 'localhost:3000',
        path: '/api/v1/resources',
        params: {
          page: nil, 
          per_page: nil
        }
      )
    end

    it { expect(controller.pagination_meta_generator(mock_request, 10)).to be_a Hash }
  end

  describe '#current_page' do
    it { expect(controller.current_page).to be 1 }
  end

  describe '#per_page' do
    it { expect(controller.per_page).to be 10 }
  end
end
