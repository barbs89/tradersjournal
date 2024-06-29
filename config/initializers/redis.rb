
require 'connection_pool'
require 'redis'

redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379/1")
pool_size = ENV.fetch("REDIS_POOL_SIZE", 5).to_i
pool_timeout = ENV.fetch("REDIS_POOL_TIMEOUT", 5).to_i

REDIS = ConnectionPool.new(size: pool_size, timeout: pool_timeout) do
  Redis.new(url: redis_url)
end
