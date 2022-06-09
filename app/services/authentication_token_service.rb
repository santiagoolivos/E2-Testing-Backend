# frozen_string_literal: true

# AuthenticationTokenService class
class AuthenticationTokenService
  def self.generate_token(user_id, duration = 24.hours)
    iat = Time.now.to_i
    exp = iat + duration.to_i
    JWT.encode({ user_id:, iat:, exp: }, ENV.fetch('JWT_SECRET', nil), 'HS256')
  end

  def self.decode_token(token)
    return if token.blank?

    decoded_token = JWT.decode(token, ENV.fetch('JWT_SECRET', nil), 'HS256')
    decoded_token[0]['user_id']
  rescue JWT::ExpiredSignature
    nil
  end
end
