require 'active_support/dependencies/autoload'

module Cashbox::Rest
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Archive
    autoload :Cancel
    autoload :Disentitle
    autoload :Helpers
    autoload :ReadWrite
  end
end
