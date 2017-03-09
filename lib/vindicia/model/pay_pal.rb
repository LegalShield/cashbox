module Vindicia::Model
  class PayPal < Base
    property :return_url
    property :cancel_url
    property :request_reference_id
    property :reference_id
  end
end
