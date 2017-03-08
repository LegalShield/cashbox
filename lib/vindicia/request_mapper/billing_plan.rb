module Vindicia::RequestMapper
  class BillingPlan < Base
    def_delegators :@model, :id
  end
end
