module Vindicia::RequestMapper
  class ProductDescription < Base
    delegate :language, :description, { to: :'@model' }
  end
end
