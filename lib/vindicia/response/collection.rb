module Vindicia::Response
  class Collection < Base
    extend Forwardable
    def_delegators :body, :each

    include Enumerable

    def total_count
      raw_body['total_count']
    end
  end
end
