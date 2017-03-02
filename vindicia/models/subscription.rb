module Vindicia::Model
  class Subscription < Base
    include Vindicia::Concern::Persistable

    attr_accessor :id,
                  :vid,
                  :account,
                  :billing_day,
                  :billing_plan,
                  :billing_state,
                  :created,
                  :currency,
                  :description,
                  :items,
                  :notify_on_transition,
                  :payment_method,
                  :policy,
                  :ends,
                  :entitled_through,
                  :most_recent_billing,
                  :next_billing,
                  :starts

  end
end
