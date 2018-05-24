module Cashbox
  class BillingPlan < Model
    include Concern::Objectable
    include Rest::Basic

    property :id
    property :vid
    property :billing_descriptor
    property :billing_notification_days
    property :created, coerce: Cashbox::Type.DateTime
    property :description
    property :message
    property :periods, coerce: Cashbox::Type.List(Cashbox::BillingPlanPeriod)
    property :status
    property :times_to_run
    property :used_on_subscriptions
  end
end
