module Cashbox
  class Account < Model
    include Concern::Objectable
    include Rest::ReadWrite
    include Rest::UpdatePayment

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

    # Note: The subscription and billing_day data mapping is based on an assumption of one subscription per account.
    #       This will need to be updated to handle many-to-many once the UI is updated to display as such.

    def subscription
      subscription = Subscription.where(account: id)
    end

    def billing_day
      return 0 unless subscription.size > 0
      subscription[0].billing_day
    end

  end
end
