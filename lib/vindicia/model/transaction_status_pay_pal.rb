module Vindicia::Model
  class TransactionStatusPayPal < Base
    include Vindicia::Model::Concern::Objectable

    property :token
    property :auth_code
    property :redirect_url
  end
end
