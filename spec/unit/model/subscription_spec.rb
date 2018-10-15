require 'spec_helper'

describe Cashbox::Subscription do
  it { is_expected.to be_a(Cashbox::Model) }
  it { is_expected.to be_a(Cashbox::Concern::Objectable) }
  it { is_expected.to be_a(Cashbox::Rest::ReadWrite) }
  it { is_expected.to be_a(Cashbox::Rest::Disentitle) }

  it { is_expected.to have_property(:id) }
  it { is_expected.to have_property(:vid) }
  it { is_expected.to have_property(:created).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:account).coercing_with(Cashbox::Account) }
  it { is_expected.to have_property(:billing_day) }
  it { is_expected.to have_property(:billing_plan).coercing_with(Cashbox::BillingPlan) }
  it { is_expected.to have_property(:billing_state) }
  it { is_expected.to have_property(:balance) }
  it { is_expected.to have_property(:cancel_reason) }
  it { is_expected.to have_property(:currency) }
  it { is_expected.to have_property(:default_billing_plan).coercing_with(Cashbox::BillingPlan) }
  it { is_expected.to have_property(:description) }
  it { is_expected.to have_property(:ends).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:entitled_through).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:items).coercing_with(Cashbox::Type.List(Cashbox::SubscriptionItem)) }
  it { is_expected.to have_property(:metadata).coercing_with(Cashbox::Metadata) }
  it { is_expected.to have_property(:message) }
  it { is_expected.to have_property(:minimum_commitment) }
  it { is_expected.to have_property(:most_recent_billing).coercing_with(Cashbox::Transaction) }
  it { is_expected.to have_property(:next_billing).coercing_with(Cashbox::Transaction) }
  it { is_expected.to have_property(:notify_on_transition).coercing_with(Cashbox::Type.Boolean) }
  it { is_expected.to have_property(:payment_method).coercing_with(Cashbox::PaymentMethod) }
  it { is_expected.to have_property(:policy) }
  it { is_expected.to have_property(:starts).coercing_with(Cashbox::Type.DateTime) }
  it { is_expected.to have_property(:status) }

  its(:object) { is_expected.to eql('Subscription') }

  context 'adding and removing subsription items' do
    let(:product_description) do
      Cashbox::ProductDescription.new({
        language: 'EN',
        description: 'describy'
      })
    end

    let(:billing_plan_period) do
      Cashbox::BillingPlanPeriod.new({
        type: 'Day',
        quantity: 1,
        cycles: 0
      })
    end

    let(:billing_plan) do
      Cashbox::BillingPlan.new({
        id: '1',
        description: 'daily',
        status: 'Active',
        periods: [ billing_plan_period ]
      })
    end

    let(:entitlement) do
      Cashbox::Entitlement.new({
        id: 'test-entitlement',
        description: 'described entitlement'
      })
    end

    let(:price) do
      Cashbox::ProductPrice.new({
        amount: 9.99,
        currency: 'USD'
      })
    end

    let(:product) do
      Cashbox::Product.new({
        id: '123456',
        descriptions: [ product_description ],
        status: 'Active',
        default_billing_plan: billing_plan,
        entitlements: [ entitlement ],
        prices: [ price ]
      })
    end

    let(:subscription) do
      Cashbox::Subscription.new(
        id: 'sub_1235',
        metadata: {
          "vin:MandateFlag": "1",
          "vin:MandateVersion": "1.0",
          "vin:MandateBankName": "The Bank NA",
          "vin:MandateID": "1234123412341234"
        }
      )
    end

    describe 'add' do
      it 'adds the subscription item to the items array' do
        subscription.add(product)

        expect(subscription.items.first.product).to eql(product)
      end
    end

    describe 'remove' do
      it 'removes the correct subscription item from the items' do
        subscription.add(product)
        expect(subscription.items).not_to be_empty

        subscription.remove(product.id)

        expect(subscription.items).to be_empty
      end
    end
  end
end
