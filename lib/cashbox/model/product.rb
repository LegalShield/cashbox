module Cashbox
  class Product < Model
    extend Cashbox::Rest::Read
    #include Cashbox::Rest::All
    #include Cashbox::Rest::Create
    #include Cashbox::Rest::Update
    #include Cashbox::Rest::Delete

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
