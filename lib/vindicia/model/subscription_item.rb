module Vindicia::Model
  class SubscriptionItem < Base
    include Vindicia::Model::Concern::Objectable

    property :id
    property :product, coerce: Vindicia::Model::Product
  end
end
