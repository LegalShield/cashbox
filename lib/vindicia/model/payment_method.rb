module Vindicia::Model
  class PaymentMethod < Base
    property :id
    property :vid
    property :created, transform_with: lambda { |v| DateTime.parse(v) }
    property :credit_card
    property :paypal, transform_with: lambda { |v| Vindicia::Model::PayPal.new(v) }
    property :primary
    property :type
  end
end
