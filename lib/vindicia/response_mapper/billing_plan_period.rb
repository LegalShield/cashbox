module Vindicia::ResponseMapper
  class BillingPlanPeriod < Base
    def map
      model_klass.new(@response.slice('type', 'quantity', 'cycles'))
    end
  end
end
