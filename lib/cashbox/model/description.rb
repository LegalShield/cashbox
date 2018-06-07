module Cashbox
  class Description < Model
    include Concern::Objectable

    property :description
    property :language
  end
end
