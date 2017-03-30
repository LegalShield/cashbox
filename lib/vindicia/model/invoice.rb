module Vindicia
  class Invoice < Model
    include Vindicia::Concern::Objectable
    include Vindicia::Concern::Persistable

    property :id
    property :vid
  end
end
