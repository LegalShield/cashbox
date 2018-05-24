module Cashbox
  class Description < Model
    include Cashbox::Concern::Objectable

    property :description
    property :language
  end
end
