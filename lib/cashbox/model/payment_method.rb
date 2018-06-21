module Cashbox
  DIRECT_DEBIT = "DirectDebit"
  CREDIT_CARD = "CreditCard"

  class PaymentMethod < Model
    include Concern::Objectable
    include Rest::ReadWrite
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

    def credit_card?
      type == CREDIT_CARD
    end

    def direct_debit?
      type == DIRECT_DEBIT
    end

    def last_digits
      self[type.underscore].last_digits
    end
  end
end
