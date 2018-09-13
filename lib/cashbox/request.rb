module Cashbox
  class Request
    include HTTParty
    format :json
    base_uri 'https://api.vindicia.com'

    def initialize(method, path, options = {})
      @method  = method
      @path    = path
      @options = options
      @uuid    = SecureRandom.uuid
    end

    def response
      log_request
      resp = Hashie::Mash.new(self.class.send(@method, @path, @options.merge(default_options)))
      log_response

      resp
    end

    private

    def default_options
      { basic_auth: { username: Cashbox.username, password: Cashbox.password }, timeout: 100 }
    end

    def log_request
      CashboxLog.create!(
        uuid: @uuid,
        operation: "Request"
      )
    end

    def log_response
      CashboxLog.create!(
        uuid: @uuid,
        operation: "Response"
      )
    end
  end
end
