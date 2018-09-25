require 'active_support/concern'

module Cashbox::Rest
  module UpdatePayment
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def update_payment(payment_method)
        request = Cashbox::Request.new(:post, "#{route(self.vid)}?update_behavior=CatchUp&replace_on_all_subscriptions=0&ignore_avs=0&ignore_cvn=0", {
          body: {
            id: self.vid,
            payment_methods: {
              object: "List",
              data: [payment_method]
            }
          }.to_json
        })
        binding.pry
        put request.response
        #self.class.cast(self, request.response)
      end
    end
  end
end
