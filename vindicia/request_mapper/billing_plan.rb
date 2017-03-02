module Vindicia::RequestMapper
  class BillingPlan < Base
    delegate :id, { to: '@model' }
  end
end
