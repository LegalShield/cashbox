require 'active_support/concern'

module Cashbox::Rest
  module Cancel
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def cancel
        request = Cashbox::Request.new(:post, "#{route(self.vid)}/actions/cancel")
        self.class.cast(self, request.response)
      end
    end
  end
end
