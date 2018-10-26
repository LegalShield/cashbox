require 'active_support/concern'

module Cashbox::Rest
  module Disentitle
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def disentitle
        request = Cashbox::Request.new(:post, "#{route(self.vid)}/actions/cancel?disentitle=true")
        self.class.cast(self, request.response)
      end
    end
  end
end
