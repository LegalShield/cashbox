require 'uri'

module Vindicia::Response
  class Object
    attr_accessor :body

    def initialize(body)
      @body = body
    end
  end
end
