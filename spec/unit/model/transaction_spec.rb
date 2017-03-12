require 'spec_helper'

describe Vindicia::Model::Transaction do
  it { is_expected.to be_a(Vindicia::Model::Base) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:account).coercing_with(Vindicia::Model::Account) }
  it { is_expected.to have_property(:amount).coercing_with(Float) }
  it { is_expected.to have_property(:billing_attempt).coercing_with(Integer) }
  it { is_expected.to have_property(:billing_descriptor) }
  it { is_expected.to have_property(:billing_plan_sequence).coercing_with(Integer) }
  it { is_expected.to have_property(:currency) }
  it { is_expected.to have_property(:items) }
  it { is_expected.to have_property(:original_billing_date).coercing_with(Vindicia::Type.DateTime) }
  it { is_expected.to have_property(:payment_processor) }
  it { is_expected.to have_property(:payment_processor_transaction_id) }
  it { is_expected.to have_property(:source_payment_method).coercing_with(Vindicia::Model::PaymentMethod) }
  it { is_expected.to have_property(:status_log) }
  it { is_expected.to have_property(:subscription).coercing_with(Vindicia::Model::Subscription) }
  it { is_expected.to have_property(:subscription_sequence) }
  it { is_expected.to have_property(:to_be_captured).coercing_with(Vindicia::Type.Boolean) }

  its(:object) { is_expected.to eql('Transaction') }
end
