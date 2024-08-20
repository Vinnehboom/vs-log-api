Pokemon.configure do |config|
  config.api_key = Rails.application.credentials.dig("pokemon_tcg_api")
end