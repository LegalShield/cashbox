module Vindicia::Response
  class Collection < Base

    def first
      body.first
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
  end
end
