module Vindicia::Model
  class Account < Base
    property :id
    property :vid
    property :created, coerce: Vindicia::Type.DateTime
    property :default_currency
    property :email
    property :email_type
    property :language
    property :name
    property :notify_before_billing
    property :payment_methods, coerce: Vindicia::Type.List(Vindicia::Model::PaymentMethod)
    property :shipping_address, coerce: Vindicia::Model::Address
  end
end
