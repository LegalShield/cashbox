module Vindicia::Response
  class Collection < Object
    extend Forwardable
    include Enumerable

    def_delegators :body, :each
    undef_method :min, :max, :sort
  end
end
