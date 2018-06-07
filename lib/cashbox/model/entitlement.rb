module Cashbox
  class Entitlement < Model
    include Concern::Objectable
    include Rest::ReadWrite

    property :id
    property :description
    property :message
  end
end
