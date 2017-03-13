module Vindicia::Model
  class Description < Base
    include Vindicia::Model::Concern::Objectable

    property :description
    property :language
  end
end
