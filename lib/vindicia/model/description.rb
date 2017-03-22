module Vindicia
  class Description < Model
    include Vindicia::Concern::Objectable

    property :description
    property :language
  end
end
