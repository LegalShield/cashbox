module Cashbox::Cache
  class MemoryStore < Store

    def initialize(options = {})
      Hashie.symbolize_keys!(options)

      @expires_in = options[:expires_in]
      @namespace = options[:namespace]
      @cache = {}
    end

    def get(key)
      value = read(cache_key_with_namespace(key))
      value = Marshal.load(value) if value

      expires_at = read(expires_at_cache_key_with_namespace(key))
      expires_at = Time.at(expires_at) if expires_at

      puts 'miss'   if value.nil?
      puts 'no ttl' if expires_at.nil?
      puts 'hit'    if expires_at && Time.now < expires_at

      if value.nil? || expires_at.nil? || Time.now < expires_at
        return value
      else
        puts 'delete'
        delete(key) && delete(expires_at_cache_key)
        return nil
      end
    end

    def set(key, value)
      write(cache_key_with_namespace(key), Marshal.dump(value))
      write(expires_at_cache_key_with_namespace(key), Time.now.to_i + @expires_in) if @expires_in
    end

    def delete(key)
      @cache.delete(key)
    end

    private

    def read(key)
      @cache[key]
    end

    def write(key, value)

    end

    def cache_key_with_namespace(key)
      [ @namespace, key ].compact.join(':')
    end

    def expires_at_cache_key_with_namespace(key)
      [ @namespace, key, 'expires_at' ].join(':')
    end
  end
end
