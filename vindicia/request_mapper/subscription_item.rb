module Vindicia::RequestMapper
  class SubscriptionItem < Base

    def product
      _present(@model.product)
    end

  end
end
