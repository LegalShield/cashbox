module Vindicia
  class TransactionStatusPayPal < Model
    include Vindicia::Concern::Objectable

    property :token
    property :auth_code
    property :redirect_url
  end
end
