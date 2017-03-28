module Vindicia
  class Request
    include HTTParty
    format :json
    base_uri 'https://api.vindicia.com'
    #debug_output $stdout

    def initialize(method, path, options = {})
      @method  = method
      @path    = path
      @options = options
    end

    def response
      response = self.class.send(@method, @path, @options.merge(default_options))
      #puts '--'
      #puts response
      #puts '--'
      #require 'pry'
      #binding.pry
      #if response['data'] && response['data'][0] && response['data'][0]['items']
        #puts '--'
        #response['data'][0]['items'][0]
        #puts '--'
      #end
      Hashie::Mash.new( response)
    end

    private

    def default_options
      { basic_auth: { username: Vindicia.username, password: Vindicia.password }}
    end
  end
end
