module Vindicia
  class SubscriptionItem < Model
    include Vindicia::Concern::Objectable

    property :id
    property :product, coerce: Vindicia::Product
  end
end
