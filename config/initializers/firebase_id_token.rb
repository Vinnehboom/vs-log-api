require 'redis'

FirebaseIdToken.configure do |config|
  config.redis = Redis.new
  config.project_ids = [Rails.application.credentials.firebase.id]
end