module Vindicia
  class Entitlement < Model
    include Vindicia::Concern::Objectable
    include Vindicia::Concern::Persistable

    property :id
    property :description
    property :message
  end
end
