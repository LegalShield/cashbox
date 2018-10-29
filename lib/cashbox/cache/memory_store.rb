module Cashbox::Cache
  class MemoryStore < Store

    def initialize(options = {})
      Hashie.symbolize_keys!(options)
      @expires_in = options[:expires_in]
      @cache = {}
    end

    def get(key)
      payload = @cache[key]

      if payload
        payload = Marshal.load(payload)
      else
        return nil
      end

      if !payload[:expires_at] || Time.now < Time.at(payload[:expires_at])
        return payload[:value]
      else
        delete(key)
        nil
      end
    end

    def set(key, value)
      payload = { value: value }
      payload[:expires_at] = Time.now.to_i + @expires_in if @expires_in
      @cache[key] = Marshal.dump(payload)
    end

    def delete(key)
      @cache.delete(key)
    end
  end
end
