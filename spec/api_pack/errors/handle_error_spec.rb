RSpec.describe Errors::HandleError do
  describe '#call' do
    context 'Error Authentication - status and details' do
      before do
        subject = described_class.new(Errors::Auth::AuthenticationError.new)
        @result = subject.call  
      end
      it { expect(@result).to match(hash_including(body_authenticate_error))}
    end
    
    context 'Error InvalidToken - status and details' do
      before do
        subject =  described_class.new(Errors::Auth::InvalidToken.new)
        @result = subject.call
      end
      
      it { expect(@result).to match(hash_including(body_invalid_token_error)) }
    end

    context 'Error MissingToken - status and details' do
      before do
        subject =  described_class.new(Errors::Auth::MissingToken.new)
        @result = subject.call
      end
      
      it { expect(@result).to match(hash_including(body_missing_token_error)) }
    end
  end
end