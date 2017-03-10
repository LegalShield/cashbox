require 'spec_helper'

describe Vindicia::Model::Transaction do
  it { should be_a(Vindicia::Model::Base) }

  it { should have_property(:id) }
  it { should have_property(:vid) }
  it { should have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:account).coercing_with(Vindicia::Model::Account) }
  it { should have_property(:amount).coercing_with(Float) }
  it { should have_property(:billing_attempt).coercing_with(Integer) }
  it { should have_property(:billing_descriptor) }
  it { should have_property(:billing_plan_sequence).coercing_with(Integer) }
  it { should have_property(:currency) }
  it { should have_property(:items) }
  it { should have_property(:original_billing_date).coercing_with(Vindicia::Type.DateTime) }
  it { should have_property(:payment_processor) }
  it { should have_property(:payment_processor_transaction_id) }
  it { should have_property(:source_payment_method).coercing_with(Vindicia::Model::PaymentMethod) }
  it { should have_property(:status_log) }
  it { should have_property(:subscription).coercing_with(Vindicia::Model::Subscription) }
  it { should have_property(:subscription_sequence) }
  it { should have_property(:to_be_captured).coercing_with(Vindicia::Type.Boolean) }
end
