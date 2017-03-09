module Vindicia::Model
  class BillingPlan < Base
    property :id
    property :vid
    property :created, transform_with: lambda { |value| DateTime.parse(value) }
    property :billing_descriptor
    property :billing_notification_days
    property :description
    property :periods, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::BillingPlanPeriod.new(v) } }
    property :status
  end
end
