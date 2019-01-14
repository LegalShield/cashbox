module Cashbox
  class SubscriptionItem < Model
    include Concern::Objectable

    property :id
    property :product, coerce: Cashbox::Product
    property :index_number, from: :index
    property :replaces
    property :replaced_by
  end
end
