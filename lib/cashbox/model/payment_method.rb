module Cashbox
  class PaymentMethod < Model
    include Cashbox::Concern::Objectable
    include Cashbox::Concern::Persistable

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :credit_card, coerce: Cashbox::CreditCard
    property :paypal, coerce: Cashbox::PayPal
    property :primary
    property :type
  end
end
