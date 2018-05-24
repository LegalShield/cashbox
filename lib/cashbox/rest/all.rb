require 'active_support/concern'

module Cashbox::Rest
  module All
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Archive
      include Cashbox::Rest::Cancel
      include Cashbox::Rest::Basic
      include Cashbox::Rest::Disentitle
    end
  end
end
