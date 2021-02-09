RSpec.describe ApiPack::JsonWebToken do
  context 'encode and decode with valid attributes' do
    before do
      ApiPack.hmac_secret = 'dcvlkcjlj4324324fdfgfe534retfdsfwrf'
      @id = Faker::Code.npi
      @payload = { id: @id }
      # time now + 1 day
      @exp = days_from_now(1)
      @token = JWT.encode({ id: @id, exp: @exp.to_i },  ApiPack.hmac_secret)
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
      let(:token_invalid) { JWT.encode({ id: Faker::Code.npi, exp: days_ago(1) },  ApiPack.hmac_secret) }

      it { expect{ described_class.decode(token_invalid) }.to raise_error ApiPack::Errors::Auth::InvalidToken }
    end
    context 'when the key secret is invalid' do
      let(:token_invalid) { JWT.encode({ id: Faker::Code.npi, exp: days_from_now(1) }, 'UY74893jmnkn') }

      it { expect{ described_class.decode(token_invalid) }.to raise_error ApiPack::Errors::Auth::InvalidToken }
    end

    context 'when the hmac secret is missing' do
      before do
        ApiPack.hmac_secret = nil
        @payload = { id: @id }
      end

      it { expect{ described_class.encode({ id: Faker::Code.npi, exp: days_from_now(1)})}.to raise_error ApiPack::Errors::Auth::MissingHmacSecret }
    end
  end
end 