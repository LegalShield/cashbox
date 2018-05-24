require 'active_support/dependencies/autoload'

module Rest
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Archiveable
    autoload :Cancelable
    autoload :Createable
    autoload :Filterable
    autoload :Findable
    autoload :Updateable
  end
end
