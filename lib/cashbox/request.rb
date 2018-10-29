require 'addressable/uri'


module Cashbox
  class Cache
    def initialize
      @cache = {}
    end

    def set(key, value)
      @cache[key] = value
    end

    def get (key)
      @cache[key]
    end
  end

  class Request
    include HTTParty
    format :json
    base_uri 'https://api.vindicia.com'

    @@cache = Cashbox::Cache.new

    def initialize(method, path, options = {})
      @method  = method
      @path    = path
      @options = options
    end

    def self.after_request_log(&block)
      @@after_request_log = block if block_given?
    end

    def self.after_request_log_block
      @@after_request_log ||= nil
    end

    def self.before_request_log(&block)
      @@before_request_log = block if block_given?
    end

    def self.before_request_log_block
      @@before_request_log ||= nil
    end

    def response
      before_request
      perform_request
      after_request
      parse_response
    end

    private

    def before_request
      if self.class.before_request_log_block
        self.class.before_request_log_block.call(@method, @path, @options)
      end

      @response = @@cache.get(cache_key)
    end

    def perform_request
      @response ||= self.class.send(@method, @path, @options.merge(default_options))
    end

    def after_request
      if self.class.after_request_log_block
        @response.tap do |res|
          self.class.after_request_log_block.call(@method, @path, @options, res)
        end
      end

      @@cache.set(cache_key, @response)
    end

    def parse_response
      Hashie::Mash.new(@response)
    end

    def cache_key
      uri = Addressable::URI.new
      uri.query_values = @options[:query]
      uri.path = @path
      uri.to_s
    end

    def default_options
      { basic_auth: { username: Cashbox.username, password: Cashbox.password }, timeout: 100 }
    end
  end
end
