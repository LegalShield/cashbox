require 'active_support/concern'

module Cashbox::Rest
  module UpdatePayment
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def update_payment(payment_method)
        request = Cashbox::Request.new(:post, route(self.vid), {
          query: {
            update_behavior: 'CatchUp',
            replace_on_all_subscriptions: false,
            ignore_avs: false,
            ignore_cvn: false
          },
          body: {
            id: self.vid,
            payment_methods: {
              object: "List",
              data: [payment_method]
            }
          }.to_json
        })
        self.class.cast(self, request.response)
      end
    end
  end
end
