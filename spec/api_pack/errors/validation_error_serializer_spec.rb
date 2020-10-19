RSpec.describe ApiPack::Errors::ValidationErrorSerializer do
  let(:record) do
    double('User')
  end

  subject do
    described_class.new(record, 'name', 'can not be blank')
  end
  
  let(:result) { subject.serialize }

  let(:match_hash) do
    {
      resource: 'r_spec_mocks_double',
      field: 'name',
      detail: 'can not be blank'
    }
  end

  describe '#serializer' do
    it { expect(result).to match(hash_including(match_hash))}
  end  
end
