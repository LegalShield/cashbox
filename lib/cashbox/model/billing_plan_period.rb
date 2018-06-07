module Cashbox
  class BillingPlanPeriod < Model
    include Concern::Objectable

    property :cycles
    property :quantity
    property :type
  end
end
