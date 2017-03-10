module Vindicia::Model
  class PaymentMethod < Base
    property :id
    property :vid
    property :created, coerce: Vindicia::Type::DateTime
    property :credit_card, coerce: Vindicia::Model::CreditCard
    property :paypal, coerce: Vindicia::Model::PayPal
    property :primary
    property :type
  end
end
