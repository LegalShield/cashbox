require 'addressable/uri'

module Cashbox
  class Request
    include HTTParty
    format :json
    base_uri 'https://api.vindicia.com'

    class << self
      attr_accessor :before_request_blocks, :after_request_blocks
    end

    def initialize(method, path, options = {})
      @method  = method
      @path    = path
      @options = options
    end

    def response
      self.class.before_request_blocks.each do |block|
        block.call(@method, @path, @options)
      end

      response = Cashbox::Cache.get(cache_key) if should_cache?
      response ||= self.class.send(@method, @path, @options.merge(default_options)).parsed_response
      Cashbox::Cache.set(cache_key, response) if should_cache?

      self.class.after_request_blocks.each do |block|
        response.tap do |res|
          block.call(@method, @path, @options, res)
        end
      end

      Hashie::Mash.new(response)
    end

    private

    def should_cache?
      @method == :get
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
