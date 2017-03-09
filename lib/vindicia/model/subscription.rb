module Vindicia::Model
  class Subscription < Base

    property :id
    property :vid
    property :billing_day
    property :billing_state
    property :currency
    property :description
    property :notify_on_transition
    property :policy
    property :most_recent_billing
    property :next_billing

    property :default_billing_plan, transform_with: lambda { |v| Vindicia::Model::BillingPlan.new(v) }
    property :account,              transform_with: lambda { |v| Vindicia::Model::Account.new(v) }
    property :billing_plan,         transform_with: lambda { |v| Vindicia::Model::BillingPlan.new(v) }
    property :items,                transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::SubscriptionItem.new(v) } }
    property :payment_method,       transform_with: lambda { |v| Vindicia::Model::PaymentMethod.new(v) }

    property :created,          transform_with: lambda { |v| DateTime.parse(v) }
    property :ends,             transform_with: lambda { |v| DateTime.parse(v) }
    property :entitled_through, transform_with: lambda { |v| DateTime.parse(v) }
    property :starts,           transform_with: lambda { |v| DateTime.parse(v) }

  end
end
