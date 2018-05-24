module Cashbox
  class Entitlement < Model
    include Rest::All

    property :id
    property :description
    property :message
  end
end
