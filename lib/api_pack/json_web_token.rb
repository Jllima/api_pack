module ApiPack
  class JsonWebToken
    def self.encode(payload, exp: ApiPack.exp)
      payload[:exp] = exp.to_i

      JWT.encode(payload, ApiPack::HMAC_SECRET)
    end

    def self.decode(token)
      JWT.decode(token, ApiPack::HMAC_SECRET).first
    rescue JWT::DecodeError => e
      raise ApiPack::Errors::Auth::InvalidToken, e.message
    end
  end
end
