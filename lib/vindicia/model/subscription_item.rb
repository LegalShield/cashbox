module Vindicia::Model
  class SubscriptionItem < Base
    property :id
    property :product, coerce: Vindicia::Model::Product
  end
end
