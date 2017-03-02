module Vindicia::ResponseMapper
  class Entitlement < Base
    def map(response)
      instance.update_attributes(response.slice(:id, :decsription))
    end
  end
end
