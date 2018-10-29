require 'active_support/dependencies/autoload'

module Cashbox::Cache
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Store
    autoload :MemoryStore
    autoload :NullStore
    #autoload :MemCacheStore
    #autoload :RedisCacheStore
  end

  class << self
    attr_accessor :cache_store

    delegate :get, :set, :delete, to: :cache_store
  end
end
