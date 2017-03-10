module Vindicia::Model
  class CreditCard < Base
    property :vid
    property :account
    property :bin
    property :last_digits
    property :account_length
    property :expiration_date
  end
end
