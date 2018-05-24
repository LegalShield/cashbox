require 'active_support/dependencies/autoload'

module Rest
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :All
    autoload :Basic
    autoload :Archive
    autoload :Cancel
    autoload :Save
    autoload :Find
  end
end
