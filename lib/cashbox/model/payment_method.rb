module Cashbox
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
      type == "CreditCard"
    end

    def direct_debit?
      type == "DirectDebit"
    end

    def last_digits
      self[type.underscore].last_digits
    end

    def card_network
      return "not a card" unless type == "CreditCard"
      bin_number = credit_card.bin
      return "Visa" if bin_number.start_with?("3")
      return "Master Card" if bin_number.start_with?("2", "5")
      "unknown network"
    end
  end
end
