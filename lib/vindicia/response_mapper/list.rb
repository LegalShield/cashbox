module Vindicia::ResponseMapper
  class List < Base
    def map
      @response['data'].map { |d| self.class.map(d) }
    end
  end
end
