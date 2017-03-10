module Vindicia::Model
  class BillingPlan < Base
    property :id
    property :vid
    property :created, coerce: Vindicia::Type.DateTime
    property :billing_descriptor
    property :billing_notification_days
    property :description
    property :periods, coerce: Vindicia::Type.List(Vindicia::Model::BillingPlanPeriod)
    property :status
  end
end
