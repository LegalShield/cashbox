require 'active_support/concern'

module Cashbox::Rest
  module Archive
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def archive
        request = Cashbox::Request.new(:post, route(self.vid), { active: false })
        cast(request.response)
      end
    end
  end
end
