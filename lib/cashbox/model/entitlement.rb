module Cashbox
  class Entitlement < Model
    include Concern::Objectable
    include Rest::Basic

    property :id
    property :description
    property :message
  end
end
