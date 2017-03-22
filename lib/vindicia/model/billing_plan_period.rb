module Vindicia::Model
  class BillingPlanPeriod < Base
    include Vindicia::Model::Concern::Objectable

    property :cycles
    property :quantity
    property :type
  end
end
