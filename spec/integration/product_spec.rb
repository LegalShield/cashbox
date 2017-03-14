require 'spec_helper'

describe 'Product' do
  before do
    Vindicia.test!
  end

  describe 'first products' do
    let(:first_product) { Vindicia::Repository::Product.first }
    subject { first_product }

    before do
      stub_get('/products')
        .with({ query: { limit: 1 } })
        .to_return({
          :status => 200,
          :body => fixture('product'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it { is_expected.to be_a(Vindicia::Model::Product) }

    its(:vid)                  { is_expected.to eql('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa') }
    its(:id)                   { is_expected.to eql('1') }
    its(:created)              { is_expected.to eql(DateTime.parse('2017-02-03T13:46:27-08:00')) }
    its(:default_billing_plan) { is_expected.to be_a(Vindicia::Model::BillingPlan)  }
    its(:descriptions)         { is_expected.to be_an(Array)  }
    its(:entitlements)         { is_expected.to be_an(Array)  }
    its(:prices)               { is_expected.to be_an(Array)  }
    its(:status)               { is_expected.to eql('Active')  }

    it 'descriptions are Vindicia::Model::ProductDescription' do
      expect(subject.descriptions.first).to be_a(Vindicia::Model::ProductDescription)
    end

    it 'entitlements are Vindicia::Model::Entitlement' do
      expect(subject.entitlements.first).to be_a(Vindicia::Model::Entitlement)
    end

    context 'records in price' do
      subject { first_product.prices.first }

      it { is_expected.to be_a(Vindicia::Model::ProductPrice) }
      its(:amount) { is_expected.to be_a(BigDecimal) }
      its(:amount) { is_expected.to eq(9.99) }
    end
  end
end
