module Cashbox
  class Period < Model
    include Concern::Objectable

    property :cycles
    property :quantity
    property :type
  end
end
