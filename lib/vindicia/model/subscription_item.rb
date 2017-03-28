module Vindicia
  class SubscriptionItem < Model
    include Vindicia::Concern::Objectable

    property :id
    property :product, coerce: Vindicia::Product
    property :index_number, from: :index
  end
end
