module Vindicia::Model
  class Product < Base
    property :id
    property :vid
    property :created, transform_with: lambda { |v| DateTime.parse(v) }
    property :billing_descriptor
    property :credit_granted
    property :default_billing_plan, transform_with: lambda { |v| Vindicia::Model::BillingPlan.new(v) }
    property :descriptions, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::ProductDescription.new(v) } }
    property :entitlements, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::Entitlement.new(v) } }
    property :prices, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::ProductPrice.new(v) } }
    property :status
  end
end
