module ApiPack
  module Errors
    module Auth
      class AuthenticationError < StandardError; end
      class InvalidToken < StandardError; end
      class MissingToken < StandardError; end
      class MissingHmacSecret < StandardError; end
    end
  end
end
