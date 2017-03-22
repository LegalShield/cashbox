module Vindicia
  class BillingPlan < Model
    include Vindicia::Concern::Objectable

    property :id
    property :vid
    property :billing_descriptor
    property :billing_notification_days
    property :created, coerce: Vindicia::Type.DateTime
    property :description
    property :periods, coerce: Vindicia::Type.List(Vindicia::BillingPlanPeriod)
    property :status
  end
end
