module Vindicia
  class RequestCollection
    def initialize(method, route, options)
      @method = method
      @route = route
      @limit = options[:query][:limit]
      options[:query][:limit] ||= 100
      @options = options
      @count = 0
    end

    def response
      responses = []
      call = 0

      while (@limit.nil? || @count <= @limit) do
        puts call+=1
        response = Vindicia::Request.new(@method, @route, @options).response
        responses.push(response)
        @limit = [ ( @limit || response['total_count']), response['total_count'] ].min
        @count += response.count
      end

      responses
    end
  end
end

