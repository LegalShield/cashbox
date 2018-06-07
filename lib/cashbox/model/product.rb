module Cashbox
  class Product < Model
    include Concern::Objectable
    include Rest::ReadWrite

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :billing_descriptor
    property :credit_granted
    property :default_billing_plan, coerce: Cashbox::BillingPlan
    property :descriptions, coerce: Cashbox::Type.List(Cashbox::ProductDescription)
    property :entitlements, coerce: Cashbox::Type.List(Cashbox::Entitlement)
    property :prices, coerce: Cashbox::Type.List(Cashbox::ProductPrice)
    property :status
  end
end
