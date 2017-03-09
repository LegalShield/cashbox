module Vindicia::Model
  class TransactionStatusPayPal < Base
    property :token
    property :auth_code
    property :redirect_url
  end
end
#{
    #"object"=>"TransactionStatusPayPal",
    #"token"=>"EC-0PY59464AS577883J",
    #"auth_code"=>"000",
    #"redirect_url"=>"https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&useraction=commit&token=EC-0PY59464AS577883J"
#}
