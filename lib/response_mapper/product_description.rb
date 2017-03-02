module Vindicia::ResponseMapper
  class ProductDescription < Base
    def map(response)
      instance.update_attributes(response.slice(:language, :description))
    end
  end
end
