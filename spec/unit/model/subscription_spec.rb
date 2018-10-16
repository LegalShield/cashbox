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

  describe '#replace_subscription_item' do
    let(:subscription) do
      Cashbox::Subscription.new({ id: 'sub_1235', items: [ old_subscription_item ] })
    end

    let(:old_subscription_item) do
      Cashbox::SubscriptionItem.new({ id: 'sub_item_old', product: old_product })
    end

    let(:new_subscription_item) do
      Cashbox::SubscriptionItem.new({ product: new_product })
    end

    let(:new_product) do
      Cashbox::Product.new({ id: 'new product' })
    end

    let(:old_product) do
      Cashbox::Product.new({ id: 'existing product' })
    end

    let(:wrong_product) do
      Cashbox::Product.new({ id: 'wrong product' })
    end

    context 'old product is found within the subscription items' do
      before do
        expect(subscription.items).to include(old_subscription_item)
        subscription.replace_subscription_item(new_product, old_product)
      end

      it 'removes the old product & subscription item from the items array' do
        expect(subscription.items).not_to include(old_subscription_item)
      end

      it 'adds the new product & subscription item to the items array' do
        new_subscription_item.replaces = old_subscription_item.product.id
        expect(subscription.items).to include(new_subscription_item)
      end

      it 'sets replaces to the removed product id' do
        expect(subscription.items[0].replaces).to eql(old_subscription_item.product.id)
      end
    end

    context 'old product is not found within the subscription items' do
      before do
        subscription.replace_subscription_item(new_product, wrong_product)
      end

      it 'sets replaces to nil' do
        expect(subscription.items[0].replaces).to eql(nil)
      end
    end
  end

  describe '#add_subscription_item' do
    let(:subscription) do
      Cashbox::Subscription.new({ id: 'sub_1235', items: [ old_subscription_item ] })
    end

    let(:new_product) do
      Cashbox::Product.new({ id: 'new product' })
    end

    let(:old_product) do
      Cashbox::Product.new({ id: 'existing product' })
    end

    let(:old_subscription_item) do
      Cashbox::SubscriptionItem.new({ id: 'sub_item_old', product: old_product })
    end

    let(:new_subscription_item) do
      Cashbox::SubscriptionItem.new({ product: new_product })
    end

    before do
      subscription.add_subscription_item(new_product)
    end

    it 'adds the subscription item to the array' do
      expect(subscription.items).to include(old_subscription_item)
      expect(subscription.items).to include(new_subscription_item)
    end
  end

  describe '#remove_subscription_item' do
    let(:subscription) do
      Cashbox::Subscription.new({ id: 'sub_1235', items: [ old_subscription_item ] })
    end

    let(:old_product) do
      Cashbox::Product.new({ id: 'existing product' })
    end

    let(:old_subscription_item) do
      Cashbox::SubscriptionItem.new({ id: 'sub_item_old', product: old_product })
    end

    before do
      expect(subscription.items).to include(old_subscription_item)
      subscription.remove_subscription_item(old_product)
    end

    it 'removes the subscription item from the array' do
      expect(subscription.items).not_to include(old_subscription_item)
    end
  end

  describe '#update_subscription_items' do
    let(:subscription) do
      Cashbox::Subscription.new({ id: 'sub_1235' })
    end

    let(:request) { double('request', { response: 'my data' }) }

    before do
      allow(Cashbox::Request).to receive(:new)
        .with(
          :post, '/subscriptions/sub_1235?effective_date=today&bill_prorated_period=true',
          { body: subscription.to_json }
          ).and_return(request)

      subscription.update_subscription_items
    end

    it 'makes the correct api call to cashbox' do
      expect(Cashbox::Request).to have_received(:new)
        .with(
          :post, '/subscriptions/sub_1235?effective_date=today&bill_prorated_period=true',
          { body: subscription.to_json }
        )
    end
  end
end
