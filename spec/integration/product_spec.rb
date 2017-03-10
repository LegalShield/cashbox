require 'spec_helper'

describe 'Product' do
  before do
    Vindicia.test!
  end

  describe 'first products' do
    subject do
      Vindicia::Repository::Product.first
    end

    before do
      stub_get('/products')
        .with({ query: { limit: 1 } })
        .to_return(:status => 200, :body => fixture('product'), :headers => { 'Content-Type': 'application/json' })
    end

    it { is_expected.to be_a(Vindicia::Model::Product) }

    its(:vid)                  { is_expected.to eql('7118699d6406494d7672503761fa21809fefaf25') }
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

    it 'product prices are Vindicia::Model::ProductPrice' do
      expect(subject.prices.first).to be_a(Vindicia::Model::ProductPrice)
    end
  end
end
