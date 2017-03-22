module Vindicia::Model
  class Price < Base
    include Vindicia::Model::Concern::Objectable

    property :amount, coerce: Float
    property :currency
  end
end
