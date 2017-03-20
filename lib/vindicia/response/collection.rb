module Vindicia::Response
  class Collection < Base
    extend Forwardable
    include Enumerable

    def_delegators :body, :each
    undef_method :min, :max, :sort
  end
end
