module Cashbox
  class BillingPlan < Model
    include Cashbox::Concern::Objectable
    include Cashbox::Concern::Persistable

    property :id
    property :vid
    property :billing_descriptor
    property :billing_notification_days
    property :created, coerce: Cashbox::Type.DateTime
    property :description
    property :message
    property :periods, coerce: Cashbox::Type.List(Cashbox::BillingPlanPeriod)
    property :status
  end
end
