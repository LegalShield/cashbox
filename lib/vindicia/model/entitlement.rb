module Vindicia::Model
  class Entitlement < Base
    include Vindicia::Model::Concern::Objectable

    property :id
    property :description
  end
end
