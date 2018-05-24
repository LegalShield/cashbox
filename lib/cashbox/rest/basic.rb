require 'active_support/concern'

module Cashbox::Rest
  module Basic
    extend ActiveSupport::Concern

    included do
      include Cashbox::Rest::Save
      include Cashbox::Rest::Find
    end
  end
end
