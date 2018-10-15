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

    def add_subscription_item(product_to_add)
      subscription_item_to_add = Cashbox::SubscriptionItem.new({
        product: product_to_add
      })

      self.items.push(subscription_item_to_add)
    end

    def remove_subscription_item(product_to_remove)
      self.items.reject! do |subscription_item|
        subscription_item.product.id == product_to_remove.id
      end || []
    end

    def replace_subscription_item(product_to_add, product_to_remove)
      self.add_subscription_item(product_to_add)

      subscription_items_to_remove = self.remove_subscription_item(product_to_remove)

      self.items.last.replaces = subscription_items_to_remove[0].id
    end

    def update_subscription_items
      Cashbox::Request.new(:post, "#{route(self.id)}?effective_date=today&bill_prorated_period=true", { body: self.to_json })
    end
  end
end
