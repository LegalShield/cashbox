module Vindicia
  class Entitlement < Model
    include Vindicia::Concern::Objectable

    property :id
    property :description
  end
end
