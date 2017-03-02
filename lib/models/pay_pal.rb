module Vindicia::Model
  class PayPal < Base
    attr_accessor :object, :return_url, :cancel_url, :request_reference_id, :reference_id
  end
end
