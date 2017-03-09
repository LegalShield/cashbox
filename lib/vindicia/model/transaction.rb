module Vindicia::Model
  class Transaction < Base
    property :id
    property :vid
    property :created, transform_with: lambda { |v| DateTime.parse(v) }
    property :amount,  transform_with: lambda { |v| v.to_f }
    property :currency
    property :account,               transform_with: lambda { |v| Vindicia::Model::Account.new(v) }
    property :source_payment_method, transform_with: lambda { |v| Vindicia::Model::PaymentMethod.new(v) }
    property :status_log,            transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::TransactionStatus.new(v) } }
    property :items,                 transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::TransactionItem.new(v) } }
    property :billing_descriptor
    property :subscription_sequence
    property :billing_plan_sequence
    property :original_billing_date, transform_with: lambda { |v| DateTime.parse(v) }
    property :billing_attempt
    property :subscription, transform_with: lambda { |v| Vindicia::Model::Subscription.new(v) }
    property :to_be_captured
    property :payment_processor
    property :payment_processor_transaction_id

  end
end
