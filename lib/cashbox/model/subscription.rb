module Cashbox
  class Subscription < Model
    include Concern::Objectable
    include Rest::ReadWrite
    include Rest::Cancel
    include Rest::Disentitle

    IN_RETRY = "In Retry".freeze
    FAILED_TO_COLLECT = "Failed To Collect".freeze
    GRACE_PERIOD = "Grace Period".freeze

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :account, coerce: Cashbox::Account
    property :billing_day
    property :billing_plan, coerce: Cashbox::BillingPlan
    property :billing_state
    property :balance
    property :cancel_reason
    property :currency
    property :default_billing_plan, coerce: Cashbox::BillingPlan
    property :description
    property :ends, coerce: Cashbox::Type.DateTime
    property :entitled_through, coerce: Cashbox::Type.DateTime
    property :items, coerce: Cashbox::Type.List(Cashbox::SubscriptionItem)
    property :metadata, coerce: Cashbox::Metadata
    property :message
    property :minimum_commitment
    property :most_recent_billing, coerce: Cashbox::Transaction
    property :next_billing, coerce: Cashbox::Transaction
    property :notify_on_transition, coerce: Cashbox::Type.Boolean
    property :payment_method, coerce: Cashbox::PaymentMethod
    property :policy
    property :starts, coerce: Cashbox::Type.DateTime
    property :status

    def in_retry?
      billing_state == IN_RETRY
    end

    def failed_to_collect?
      billing_state == FAILED_TO_COLLECT
    end

    def grace_period?
      billing_state == GRACE_PERIOD
    end

    def add_subscription_items(subscprition_items, bill_prorated)
      request = Cashbox::Request.new(:post, route(vid), 
          {
              query: { 
                  effective_date: 'today',
                  bill_prorated_period: bill_prorated
              },
              body: {
                  id: id,
                  items: subscprition_items
              }.to_json
          })
      self.class.cast(self, request.response)  
    end
  end
end
