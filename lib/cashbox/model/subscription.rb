module Cashbox
  class Subscription < Model
    include Cashbox::Concern::Objectable
    include Cashbox::Concern::Persistable

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :account, coerce: Cashbox::Account
    property :billing_day
    property :billing_plan, coerce: Cashbox::BillingPlan
    property :billing_state
    property :cancel_reason
    property :currency
    property :default_billing_plan, coerce: Cashbox::BillingPlan
    property :description
    property :ends, coerce: Cashbox::Type.DateTime
    property :entitled_through, coerce: Cashbox::Type.DateTime
    property :items, coerce: Cashbox::Type.List(Cashbox::SubscriptionItem)
    property :message
    property :minimum_commitment
    property :most_recent_billing, coerce: Cashbox::Type.DateTime
    property :next_billing, coerce: Cashbox::Type.DateTime
    property :notify_on_transition, coerce: Cashbox::Type.Boolean
    property :payment_method, coerce: Cashbox::PaymentMethod
    property :policy
    property :starts, coerce: Cashbox::Type.DateTime
    property :status
  end
end