module Vindicia::Model
  class BillingPlan < Base
    #include Vindicia::Concern::Persistable

    property :id
    property :vid
    property :status
    property :billing_descriptor
    property :description
    property :billing_notification_days
    property :created, transform_with: lambda { |value| DateTime.parse(value) }
    property :periods, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::BillingPlanPeriod.new(v) } }

  end
end
