module Cashbox
  class SubscriptionItem < Model

    property :id
    property :product, coerce: Cashbox::Product
    property :index_number, from: :index
  end
end
