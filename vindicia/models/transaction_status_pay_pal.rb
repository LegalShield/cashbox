module Vindicia::Model
  class TransactionStatusPayPal < Base
    attr_accessor :object,
                  :token,
                  :auth_code,
                  :redirect_url
  end
end
#{
    #"object"=>"TransactionStatusPayPal",
    #"token"=>"EC-0PY59464AS577883J",
    #"auth_code"=>"000",
    #"redirect_url"=>"https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&useraction=commit&token=EC-0PY59464AS577883J"
#}
