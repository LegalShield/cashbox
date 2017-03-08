module Vindicia::Model
  class BillingPlan < Base
    #include Vindicia::Concern::Persistable

    attr_accessor :id,
                  :vid,
                  :created,
                  :billing_descriptor,
                  :billing_notification_days,
                  :description,
                  :periods,
                  :status

  end
end
