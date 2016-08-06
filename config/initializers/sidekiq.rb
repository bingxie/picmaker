redis_url = URI.parse(URI.extract(REDIS.inspect).first).to_s
config_hash = { url: redis_url, namespace: ENV['SIDEKIQ_NAMESPACE'] }

Sidekiq.configure_server do |config|
  config.redis = config_hash
end

Sidekiq.configure_client do |config|
  config.redis = config_hash
end
