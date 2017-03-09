module Vindicia
  class Request
    include HTTParty
    #debug_output $stderr
    format :json

    def initialize(method, path, options = {})
      @method = method
      @path = path
      @options = options
    end

    def perform
      self.class.send(@method, @path, @options.merge(basic_auth: basic_auth))
    end

    private

    def basic_auth
      { username: Vindicia.username, password: Vindicia.password }
    end
  end
end
