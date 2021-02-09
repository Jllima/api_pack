module ApiPack
  class JsonWebToken
    def self.encode(payload, exp: ApiPack.exp)
      raise ApiPack::Errors::Auth::MissingHmacSecret if ApiPack.hmac_secret.nil?

      payload[:exp] = exp.to_i

      JWT.encode(payload, ApiPack.hmac_secret)
    rescue ApiPack::Errors::Auth::MissingHmacSecret
      raise ApiPack::Errors::Auth::MissingHmacSecret, 'ApiPach.hmac_secret is missing'
    end

    def self.decode(token)
      JWT.decode(token, ApiPack.hmac_secret).first
    rescue JWT::DecodeError => e
      raise ApiPack::Errors::Auth::InvalidToken, e.message
    end
  end
end
