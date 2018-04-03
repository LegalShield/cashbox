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

    def response
      res = self.class.send(@method, @path, @options.merge(default_options))
      #require 'pry'
      #binding.pry
      #puts res
      #File.open('./invoice.json', 'w') {|f| f.write(res)}
      Hashie::Mash.new(res)
    end

    private

    def default_options
      { basic_auth: { username: Cashbox.username, password: Cashbox.password }}
    end
  end
end
