module Cashbox
  class Invoice < Model
    include Concern::Objectable
    include Concern::Persistable

    property :id
    property :vid
  end
end
