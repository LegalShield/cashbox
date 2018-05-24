module Cashbox
  class TransactionStatusPayPal < Model
    include Cashbox::Concern::Objectable

    property :token
    property :auth_code
    property :redirect_url
  end
end
