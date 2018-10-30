module Cashbox::Cache
  class MemoryStore < Store

    def initialize(options = {})
      Hashie.symbolize_keys!(options)

      @expires_in = options[:expires_in]
      @namespace = options[:namespace]
      @cache = {}
    end

    def get(key)
      value_cache_key = cache_key_with_namespace(key)
      expires_at_cache_key = expires_at_cache_key_with_namespace(key)

      value = @cache[value_cache_key]
      value = Marshal.load(value) if value

      expires_at = @cache[expires_at_cache_key]
      expires_at = Time.at(expires_at) if expires_at

      if value.nil? || expires_at.nil? || Time.now < expires_at
        puts 'hit or nil'
        return value
      else
        puts 'miss or timeout'
        delete(key) && delete(expires_at_cache_key)
        return nil
      end
    end

    def set(key, value)
      value_cache_key = cache_key_with_namespace(key)
      expires_at_cache_key = expires_at_cache_key_with_namespace(key)

      @cache[value_cache_key] = Marshal.dump(value)
      @cache[expires_at_cache_key] = (Time.now.to_i + @expires_in) if @expires_in
    end

    def delete(key)
      @cache.delete(key)
    end

    private

    def cache_key_with_namespace(key)
      [ @namespace, key ].compact.join(':')
    end

    def expires_at_cache_key_with_namespace(key)
      [ @namespace, key, 'expires_at' ].join(':')
    end
  end
end
