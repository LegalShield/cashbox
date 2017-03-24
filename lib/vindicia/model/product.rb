module Vindicia
  class Product < Model
    include Vindicia::Concern::Objectable
    include Vindicia::Concern::Persistable

    property :id
    property :vid
    property :created, coerce: Vindicia::Type.DateTime
    property :billing_descriptor
    property :credit_granted
    property :default_billing_plan, coerce: Vindicia::BillingPlan
    property :descriptions, coerce: Vindicia::Type.List(Vindicia::ProductDescription)
    property :entitlements, coerce: Vindicia::Type.List(Vindicia::Entitlement)
    property :prices, coerce: Vindicia::Type.List(Vindicia::ProductPrice)
    property :status
  end
end
