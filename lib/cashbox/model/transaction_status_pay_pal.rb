module Cashbox
  class TransactionStatusPayPal < Model

    property :token
    property :auth_code
    property :redirect_url
  end
end
