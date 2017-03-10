module Vindicia::Model
  class Product < Base
    property :id
    property :vid
    property :created, coerce: Vindicia::Type.DateTime
    property :billing_descriptor
    property :credit_granted
    property :default_billing_plan, coerce: Vindicia::Model::BillingPlan
    property :descriptions, coerce: Vindicia::Type.List(Vindicia::Model::ProductDescription)
    property :entitlements, coerce: Vindicia::Type.List(Vindicia::Model::Entitlement)
    property :prices, coerce: Vindicia::Type.List(Vindicia::Model::ProductPrice)
    property :status
  end
end
