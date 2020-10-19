RSpec.describe ApiPack::Errors::ValidationErrorsSerializer do
  let(:details) do
    { 
      email: [{error: :blank}, {error: :invalid, value: nil}],
      password: [{error: :blank}]
    }
  end

  let(:messages) do
    { 
      email: ['Can not blank', 'invalid email'],
      password: ['Can not blank']
    }
  end

  before do 
    errors = double()
    allow(errors).to receive(:details).and_return(details)
    allow(errors).to receive(:messages).and_return(messages)

    @record = instance_double(
      'User', 
      errors: errors
    )
  end

  subject do
    described_class.new(@record)
  end

  it { expect(subject.serialize).to include_hash_matching(detail: 'Can not blank') }
  it { expect(subject.serialize).to include_hash_matching(detail: 'invalid email') }
  it { expect(subject.serialize).to include_hash_matching(field: :email) }
  it { expect(subject.serialize).to include_hash_matching(field: :password) }
  it { expect(subject.serialize).to include_hash_matching(resource: 'r_spec_mocks_instance_verifying_double') }
end