require 'active_support/concern'

module Cashbox::Rest
  module Refund
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def refund
        request = Cashbox::Request.new(:post, "#{route(self.vid)}/refunds")
        self.class.cast(self, request.response)
      end
    end
  end
end