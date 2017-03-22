module Vindicia::Model
  class Period < Base
    include Vindicia::Model::Concern::Objectable

    property :cycles
    property :quantity
    property :type
  end
end
