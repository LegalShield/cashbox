require "active_support/concern"

module Cashbox::Rest
  module UpdateSubscription
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def reset_bill_date
        request = Cashbox::Request.new(:post, "#{route(self.vid)}?effective_date=today&bill_prorated_period=true", {
          body: self.to_json
        })
        self.class.cast(self, request.response)
      end
    end
  end
end
