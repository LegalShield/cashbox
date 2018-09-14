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
      @@after_request_log = block
    end

    def self.after_request_log_block
      @@after_request_log ||= nil
    end

    def self.after_request_log_block_call
      @@after_request_log.call
    end

    def response
      res = Hashie::Mash.new(self.class.send(@method, @path, @options.merge(default_options)))

      if self.class.after_request_log_block
        self.class.after_request_log_block_call(@method, @path, @options, res)
      end

      res
    end

    private

    def default_options
      { basic_auth: { username: Cashbox.username, password: Cashbox.password }, timeout: 100 }
    end
  end
end
