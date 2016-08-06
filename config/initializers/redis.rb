redis = Hash.new { |h, k| h[k] = { url: (ENV['REDIS_URL'] || 'redis://localhost:6379') } }

# redis['development'] = { url: 'redis://localhost:6390' }
# redis['test'] = { url: 'redis://localhost:6391' }

uri = URI.parse(redis.dig(Rails.env, :url))

# Boot local redis in dev and test
if Rails.env.development? || Rails.env.test?
  system("redis-server --port #{uri.port} --daemonize yes")
  raise "Couldn't start redis" unless $CHILD_STATUS.exitstatus.zero?
end

# Initialize application-wide constant.
REDIS = Redis.new(url: uri.to_s, port: uri.port).freeze
