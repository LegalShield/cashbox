require 'uri'

module Vindicia
  class Response

    def initialize(request)
      @request = request
    end

    def body
      @body ||= map(raw_body)
    end

    def raw_body
      response.to_h
    end

    def count
      body.count
    end

    def total_count
      raw_body['total_count']
    end

    def has_next?
      !!raw_body['next']
    end

    def next
      Vindicia::Response.new(Vindicia::Request.new(:get, raw_body['next']))
    end

    def has_previous?
      !!raw_body['previous']
    end

    def previous
      uri = URI(raw_body['previous'])
      Vindicia::Response.new(Vindicia::Request.new(:get, uri.path, URI::decode_www_form(uri.query).to_h))
    end

    private

    def map(hash)
      case hash['object']
      when 'List'
        hash['data'].map {|d| map(d) }
      when 'Error'
        throw Vindicia::Exception.new(response.to_h)
      else
        "Vindicia::Model::#{hash['object']}".constantize.new(hash)
      end
    end

    def response
      @response ||= @request.perform
    end

  end
end
