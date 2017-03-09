module Vindicia::Model
  class Subscription < Base
    property :id
    property :vid
    property :created, transform_with: lambda { |v| DateTime.parse(v) }

    property :account, transform_with: lambda { |v| Vindicia::Model::Account.new(v) }
    property :billing_day
    property :billing_plan, transform_with: lambda { |v| Vindicia::Model::BillingPlan.new(v) }
    property :billing_state
    property :currency
    property :default_billing_plan, transform_with: lambda { |v| Vindicia::Model::BillingPlan.new(v) }
    property :description
    property :ends, transform_with: lambda { |v| DateTime.parse(v) }
    property :entitled_through, transform_with: lambda { |v| DateTime.parse(v) }
    property :items, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::SubscriptionItem.new(v) } }
    property :most_recent_billing
    property :next_billing
    property :notify_on_transition
    property :payment_method, transform_with: lambda { |v| Vindicia::Model::PaymentMethod.new(v) }
    property :policy
    property :starts, transform_with: lambda { |v| DateTime.parse(v) }
  end
end
