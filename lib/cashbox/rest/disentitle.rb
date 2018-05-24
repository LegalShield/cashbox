require 'active_support/concern'

module Cashbox::Rest
  module Disentitle
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Helpers
      include Cashbox::Rest::Cancel

      def disentitle
        cancel({ disentitle: 'Yes' })
      end
    end
  end
end
