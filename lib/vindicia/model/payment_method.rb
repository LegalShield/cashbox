module Vindicia
  class PaymentMethod < Model
    include Vindicia::Concern::Objectable
    include Vindicia::Concern::Persistable

    property :id
    property :vid
    property :created, coerce: Vindicia::Type.DateTime
    property :credit_card, coerce: Vindicia::CreditCard
    property :paypal, coerce: Vindicia::PayPal
    property :primary
    property :type
  end
end
