require 'active_support/concern'

module Cashbox::Rest
  module Cancel
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

    #def destroy
      #request = Cashbox::Request.new(:post, "#{route(@instance.vid)}/actions/cancel")
      #cast(request.response)
    #end

      def cancel
        #"/action/cancel"
        request = Cashbox::Request.new(:post, "#{route(self.vid)}/actions/cancel")
        cast(request.response)
      end
    end
  end
end
