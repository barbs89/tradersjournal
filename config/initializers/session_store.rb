Rails.application.config.session_store :redis_session_store, 
  key: '_traders_journal_session',
  redis: {
		expire_after: 120.minutes,  # cookie expiration
    key_prefix: 'tradersjournal:session:',
    url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1")
  },
	serializer: :hybrid, # migrate from Marshal to JSON
	on_redis_down: ->(*a) { logger.error("Redis down! #{a.inspect}") }
