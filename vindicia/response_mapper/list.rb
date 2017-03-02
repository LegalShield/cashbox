module Vindicia::ResponseMapper
  class List < Base
    def map(response)
      response[:data].inject(instance) { |i, o| i.push(_map(o)) }
    end
  end
end
