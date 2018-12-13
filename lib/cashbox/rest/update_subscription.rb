require 'active_support/concern'

module Cashbox::Rest
  module UpdateSubscription
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def update_subscription(update_subscprition_items)
        request = Cashbox::Request.new(:post, route(self.vid), 
            {
                query: { 
                    effective_date: 'today',
                    bill_prorated_period: false
                },
                body: {
                    id: self.vid,
                    items: update_subscprition_items
                }.to_json
            })
        self.class.cast(self, request.response)  
      end
    end
  end
end
