module Vindicia
  class BillingPlanPeriod < Model
    include Vindicia::Concern::Objectable

    property :cycles
    property :quantity
    property :type
  end
end
