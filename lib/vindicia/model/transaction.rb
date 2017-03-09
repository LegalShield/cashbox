module Vindicia::Model
  class Transaction < Base
    property :id
    property :vid
    property :created, transform_with: lambda { |v| DateTime.parse(v) }
    property :account, transform_with: lambda { |v| Vindicia::Model::Account.new(v) }
    property :amount, transform_with: lambda { |v| v.to_f }
    property :billing_attempt
    property :billing_descriptor
    property :billing_plan_sequence
    property :currency
    property :items, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::TransactionItem.new(v) } }
    property :original_billing_date, transform_with: lambda { |v| DateTime.parse(v) }
    property :payment_processor
    property :payment_processor_transaction_id
    property :source_payment_method, transform_with: lambda { |v| Vindicia::Model::PaymentMethod.new(v) }
    property :status_log, transform_with: lambda { |d| d['data'].map { |v| Vindicia::Model::TransactionStatus.new(v) } }
    property :subscription, transform_with: lambda { |v| Vindicia::Model::Subscription.new(v) }
    property :subscription_sequence
    property :to_be_captured
  end
end
