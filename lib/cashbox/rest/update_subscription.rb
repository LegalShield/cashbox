require "active_support/concern"

module Cashbox::Rest
  module UpdateSubscription
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def update_subscription(new_product_id, old_product_id = nil)
        body = {
          object: "Subscription",
          id: self.vid,
          product: {
            object: "Product",
            id: new_product_id
          }
        }

        if old_product_id
          body[:replaces] = {
            object: "SubscriptionItem",
            product: {
              object: "Product",
              id: old_product_id
            }
          }
        end

        request = Cashbox::Request.new(:post, "#{route(self.vid)}?effective_date=today&bill_prorated_period=true", {
          body: {
            items: [
              body
            ]
          }.to_json
        })
        self.class.cast(self, request.response)
      end
    end
  end
end