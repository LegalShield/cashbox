module Cashbox
  class Entitlement < Model
    include Cashbox::Concern::Objectable
    include Cashbox::Concern::Persistable

    property :id
    property :description
    property :message
  end
end
