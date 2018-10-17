module Cashbox
  class Subscription < Model
    include Concern::Objectable
    include Rest::ReadWrite
    include Rest::Cancel
    include Rest::Disentitle
    GRACE_STATUSES = %w[Retry Grace\ Period Failure\ to\ collect].freeze

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

    def grace?
      GRACE_STATUSES.include?(billing_state)
    end

    def add_subscription_item(product_to_add)
      subscription_item_to_add = Cashbox::SubscriptionItem.new({
        product: product_to_add
      })

      items.push(subscription_item_to_add)
    end

    def remove_subscription_item(product_to_remove)
      index = (items || []).index {|subscription_item| subscription_item.product.id == product_to_remove.id }
      items.delete_at(index) if index
    end

    def replace_subscription_item(product_to_add, product_to_remove)
      subscription_item_to_remove = remove_subscription_item(product_to_remove)

      add_subscription_item(product_to_add)
      items.last.replaces = subscription_item_to_remove.product.id if subscription_item_to_remove
    end

    def update_subscription_items
      Cashbox::Request.new(:post, "#{route(id)}?effective_date=today&bill_prorated_period=true", { body: self.to_json })
    end
  end
end
