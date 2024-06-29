# Retrieve a connection from the pool before performing Redis operations.
# This is done using the with method, which yields a connection to the block.

module RedisHelper
  def with_redis(&block)
    REDIS.with(&block)
  end
end
