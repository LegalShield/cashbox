module Cashbox
  class Account < Model
    include Concern::Objectable
    include Concern::Persistable

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :default_currency
    property :email
    property :email_type
    property :language
    property :metadata
    property :name
    property :notify_before_billing
    property :payment_methods, coerce: Cashbox::Type.List(Cashbox::PaymentMethod)
    property :shipping_address, coerce: Cashbox::Address

    #has_many :subscriptions

    def subscriptions
      Subscription.where({ account: 1 })
    end
  end
end
