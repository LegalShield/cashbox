module Cashbox
  class PaymentMethod < Model
    include Concern::Objectable
    include Rest::Basic
    include Rest::Archive

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :credit_card, coerce: Cashbox::CreditCard
    property :direct_debit, coerce: Cashbox::DirectDebit
    property :paypal, coerce: Cashbox::PayPal
    property :primary
    property :active
    property :type
    property :account_holder
    property :billing_address
    property :validation_status
  end
end
