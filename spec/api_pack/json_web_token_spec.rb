RSpec.describe ApiPack::JsonWebToken do
  let(:hmac_secret) { ApiPack::HMAC_SECRET }

  context 'encode and decode with valid attributes' do
    before do
      @id = Faker::Code.npi
      @payload = { id: @id }
      # time now + 1 day
      @exp = days_from_now(1)
      @token = JWT.encode({ id: @id, exp: @exp.to_i }, hmac_secret)
    end
    
    describe ".encode" do
      context 'ensure the return of a token valid when the payload is valid' do
        it { expect(described_class.encode(@payload, exp: @exp)).to eq @token }
      end
    end

    describe '.decode' do
      context 'ensure the return of a payload when the token is valid' do
        let(:payload_return) { { "id"=> @id, "exp"=>@exp } }

        it { expect(described_class.decode(@token)).to eq payload_return }
      end
    end
  end
  
  context 'ensure the return of an exception' do
    context 'when the time has expired' do
      let(:token_invalid) { JWT.encode({ id: Faker::Code.npi, exp: days_ago(1) }, hmac_secret) }

      it { expect{ described_class.decode(token_invalid) }.to raise_error ApiPack::Errors::Auth::InvalidToken }
    end
    context 'when the key secret is invalid' do
      let(:token_invalid) { JWT.encode({ id: Faker::Code.npi, exp: days_from_now(1) }, 'UY74893jmnkn') }

      it { expect{ described_class.decode(token_invalid) }.to raise_error ApiPack::Errors::Auth::InvalidToken }
    end
  end
end 