module Vindicia::Model
  class Account < Base
    property :id
    property :vid
    property :created, transform_with: lambda { |v| DateTime.parse(v) }
    property :default_currency
    property :email
    property :email_type
    property :name
    property :notify_before_billing
    property :payment_methods, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::PaymentMethod.new(v) } }
  end
end
