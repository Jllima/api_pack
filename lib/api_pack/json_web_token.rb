module ApiPack
  class JsonWebToken
    def self.encode(payload, exp: 24.hours.from_now)
      payload[:exp] = exp.to_i

      JWT.encode(payload, ApiPack::HMAC_SECRET)
    end

    def self.decode(token)
      body = JWT.decode(token, ApiPack::HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::DecodeError => e
      raise Errors::Auth::InvalidToken, e.message
    end
  end
end
