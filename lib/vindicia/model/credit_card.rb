module Vindicia::Model
  class CreditCard < Base
    property :vid
    property :account
    property :account_length
    property :bin
    property :expiration_date
    property :last_digits
  end
end