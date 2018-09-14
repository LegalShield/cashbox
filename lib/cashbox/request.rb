module Cashbox
  class Request
    include HTTParty
    format :json
    base_uri 'https://api.vindicia.com'

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

    def response
      resp = self.class.send(@method, @path, @options.merge(default_options))

      if self.class.after_request_log_block
        resp.tap do |r|
          self.class.after_request_log_block.call(@method, @path, @options, r)
        end
      end

      Hashie::Mash.new(resp)
    end

    private

    def default_options
      { basic_auth: { username: Cashbox.username, password: Cashbox.password }, timeout: 100 }
    end
  end
end
