require 'active_support/concern'

module Cashbox::Rest
  module Save
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers

      def save
        save!
      rescue Exception
        false
      end

      def save!
        request = Cashbox::Request.new(:post, route(self.vid), { body: self.to_json })
        self.class.cast(self, request.response)
        true
      end
    end
  end
end
