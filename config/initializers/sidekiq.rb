Sidekiq.configure_server do |config|
    config.redis = { url: Rails.application.credentials.dig(:REDIS_URL) || ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
  end
  
Sidekiq.configure_client do |config|
    config.redis = { url: Rails.application.credentials.dig(:REDIS_URL) || ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
end