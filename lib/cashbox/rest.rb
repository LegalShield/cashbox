require 'active_support/dependencies/autoload'

module Cashbox::Rest
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :All
    autoload :Archive
    autoload :Basic
    autoload :Cancel
    autoload :Disentitle
    autoload :Find
    autoload :Helpers
    autoload :Save
  end
end
