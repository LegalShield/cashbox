module Vindicia::Model
  class TransactionStatusPayPal < Base
    property :token
    property :auth_code
    property :redirect_url
  end
end
