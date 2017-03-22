module Vindicia
  class PayPal < Model
    include Vindicia::Concern::Objectable

    property :cancel_url
    property :reference_id
    property :request_reference_id
    property :return_url
  end
end
