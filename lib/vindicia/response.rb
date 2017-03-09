module Vindicia
  class Response

    def initialize(request)
      @request = request
    end

    def body
      @body ||= map(response.to_h)
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
