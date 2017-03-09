module Vindicia::Model
  class SubscriptionItem < Base
    property :id
    property :product, transform_with: lambda { |v| Vindicia::Model::Product.new(v) }
  end
end
