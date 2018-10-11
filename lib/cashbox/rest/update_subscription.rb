require 'active_support/concern'

module Cashbox::Rest
  module UpdateSubscription
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def update_subscription(new_product, delete_product)
        body = {
          object: "Subscription",
          id: self.vid,
          product: {
            object: "Product",
            id: new_product
          }
        }
        if new_product
          body.product = {
            object: "Product",
            id: new_product
          }
        end

        if delete_product
          body.replaces = {
            object: "SubscriptionItem",
            product: {
              object: "Product",
              id: delete_product
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
