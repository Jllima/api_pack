module ApiPack
  class JsonWebToken
    # exp: 24 hours from now
    def self.encode(payload, exp: (Time.now + 1 * 86_400).to_i)
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
