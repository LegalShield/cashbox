module Cashbox
  class Account < Model
    include Rest::All

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :default_currency
    property :email
    property :email_type
    property :language
    property :name
    property :notify_before_billing
    property :payment_methods, coerce: Cashbox::Type.List(Cashbox::PaymentMethod)
    property :shipping_address, coerce: Cashbox::Address
  end
end
