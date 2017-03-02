module Vindicia::ResponseMapper
  class BillingPlanPeriod < Base
    def map(response)
      instance.update_attributes(response.slice(:type, :quantity, :cycles))
    end
  end
end
