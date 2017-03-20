require 'uri'

module Vindicia::Response
  class Base
    attr_accessor :body

    def initialize(body)
      @body = body
    end
  end
end
