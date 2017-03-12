require 'uri'

module Vindicia::Response
  class Base
    def initialize(request)
      @request = request
    end

    def body
      @body ||= cast(raw_body)
    end

    def raw_body
      response.to_h
    end

    private

    def cast(hash)
      case hash['object']
      when 'List'
        hash['data'].map {|d| cast(d) }
      when 'Error'
        Vindicia::Exception.new(response.to_h)
      else
        Vindicia::Model.const_get(hash['object']).new(hash)
      end
    end

    def response
      @response ||= @request.perform
    end
  end
end
