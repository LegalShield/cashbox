module Vindicia::Model
  class PayPal < Base
    property :cancel_url
    property :reference_id
    property :request_reference_id
    property :return_url
  end
end
