module Instantiable
  def redis_has_key?(key)
    !!redis_key_from(key)
  end

  def redis_key_from(key)
    redis_instance.get(key)
  end

  def redis_set(key, value)
    redis_instance.set(key, value) == 'OK'
  end

  def redis_instance
    redis_settings = Settings.redis.deep_symbolize_keys
    Redis.new(host: redis_settings[:host],port: redis_settings[:port])
  end
end
