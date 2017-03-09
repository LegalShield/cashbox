module Vindicia::Model
  class PaymentMethod < Base
    #include Vindicia::Concern::Persistable

    property :id
    property :vid
    property :credit_card
    property :primary
    property :type

    property :created, transform_with: lambda { |v| DateTime.parse(v) }
    property :paypal, transform_with: lambda { |v| Vindicia::Model::PayPal.new(v) }
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
