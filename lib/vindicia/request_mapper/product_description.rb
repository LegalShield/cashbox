module Vindicia::RequestMapper
  class ProductDescription < Base
    def_delegators :@model, :language, :description
  end
end
