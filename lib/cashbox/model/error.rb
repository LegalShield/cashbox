module Cashbox
  class Error < Model
    include Cashbox::Concern::Objectable

    property :message
  end
end
