module Cashbox
  class BillingPlanPeriod < Model
    include Cashbox::Concern::Objectable

    property :cycles
    property :quantity
    property :type
  end
end
