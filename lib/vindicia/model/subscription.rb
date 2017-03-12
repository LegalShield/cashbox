module Vindicia::Model
  class Subscription < Base
    property :id
    property :vid
    property :created, coerce: Vindicia::Type.DateTime
    property :account, coerce: Vindicia::Model::Account
    property :billing_day
    property :billing_plan, coerce: Vindicia::Model::BillingPlan
    property :billing_state
    property :currency
    property :default_billing_plan, coerce: Vindicia::Model::BillingPlan
    property :description
    property :ends, coerce: Vindicia::Type.DateTime
    property :entitled_through, coerce: Vindicia::Type.DateTime
    property :items, coerce: Vindicia::Type.List(Vindicia::Model::SubscriptionItem)
    property :most_recent_billing, coerce: Vindicia::Type.DateTime
    property :next_billing, coerce: Vindicia::Type.DateTime
    property :notify_on_transition, coerce: Vindicia::Type.Boolean
    property :payment_method, coerce: Vindicia::Model::PaymentMethod
    property :policy
    property :starts, coerce: Vindicia::Type.DateTime
  end
end
