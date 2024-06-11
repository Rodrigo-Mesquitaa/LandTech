config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise[:jwt_secret_key]
  end
  