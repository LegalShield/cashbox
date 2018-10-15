module Cashbox
  class Subscription < Model
    include Concern::Objectable
    include Rest::ReadWrite
    include Rest::Cancel
    include Rest::Disentitle

    property :id
    property :vid
    property :created, coerce: Cashbox::Type.DateTime
    property :account, coerce: Cashbox::Account
    property :billing_day
    property :billing_plan, coerce: Cashbox::BillingPlan
    property :billing_state
    property :balance
    property :cancel_reason
    property :currency
    property :default_billing_plan, coerce: Cashbox::BillingPlan
    property :description
    property :ends, coerce: Cashbox::Type.DateTime
    property :entitled_through, coerce: Cashbox::Type.DateTime
    property :items, coerce: Cashbox::Type.List(Cashbox::SubscriptionItem)
    property :metadata, coerce: Cashbox::Metadata
    property :message
    property :minimum_commitment
    property :most_recent_billing, coerce: Cashbox::Transaction
    property :next_billing, coerce: Cashbox::Transaction
    property :notify_on_transition, coerce: Cashbox::Type.Boolean
    property :payment_method, coerce: Cashbox::PaymentMethod
    property :policy
    property :starts, coerce: Cashbox::Type.DateTime
    property :status

    def add(product)
      new_subscription_item = SubscriptionItem.new({ product: product })
      self.items = items || []
      self.items.push(new_subscription_item)
    end

    def remove(product_id)
      self.items.each do |item|
        self.items.delete(item) if item.product.id == product_id
      end
    end
  end
end
