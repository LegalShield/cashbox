module Vindicia
  class Subscription < Model
    include Vindicia::Concern::Objectable
    include Vindicia::Concern::Persistable

    property :id
    property :vid
    property :created, coerce: Vindicia::Type.DateTime
    property :account, coerce: Vindicia::Account
    property :billing_day
    property :billing_plan, coerce: Vindicia::BillingPlan
    property :billing_state
    property :cancel_reason
    property :currency
    property :default_billing_plan, coerce: Vindicia::BillingPlan
    property :description
    property :ends, coerce: Vindicia::Type.DateTime
    property :entitled_through, coerce: Vindicia::Type.DateTime
    property :items, coerce: Vindicia::Type.List(Vindicia::SubscriptionItem)
    property :message
    property :minimum_commitment
    property :most_recent_billing, coerce: Vindicia::Type.DateTime
    property :next_billing, coerce: Vindicia::Type.DateTime
    property :notify_on_transition, coerce: Vindicia::Type.Boolean
    property :payment_method, coerce: Vindicia::PaymentMethod
    property :policy
    property :starts, coerce: Vindicia::Type.DateTime
    property :status
  end
end
