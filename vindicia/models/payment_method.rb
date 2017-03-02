module Vindicia::Model
  class PaymentMethod < Base
    include Vindicia::Concern::Persistable

    attr_accessor :id,
                  :vid,
                  :created,
                  :credit_card,
                  :primary,
                  :type
  end
end


#{
  #"object": "PaymentMethod",
  #"id": "paym_1234",
  #"type": "CreditCard",

  #"credit_card": {
    #"object": "CreditCard",
    #"account": "341111111111111",
    #"expiration_date": "201805"
  #},

  #"account_holder": "Charles X. Brown",

  #"billing_address": {
    #"object": "Address",
    #"name": "Charlie Brown",
    #"line1": "123 Main Street",
    #"city": "San Francisco",
    #"district": "CA",
    #"postal_code": "94105",
    #"country": "US",
    #"phone": "415-555-3212"
  #},

  #"customer_specified_type": "Personal Amex",
  #"primary": true,
  #"policy": {
    #"min_chargeback_probability": 100,
    #"validate": 1
  #}
#}
