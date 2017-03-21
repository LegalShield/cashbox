require 'spec_helper'

describe 'Product' do before { Vindicia.test!  }
  after { Vindicia.production! }

  describe 'first products' do
    subject do
      Vindicia::Repository::Product.first
    end

    before do
      stub_get('/products')
        .with({ query: { limit: 1 } })
        .to_return({
          :status => 200,
          :body => fixture('products'),
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

    it 'product prices are Vindicia::Model::ProductPrice' do
      expect(subject.prices.first).to be_a(Vindicia::Model::ProductPrice)
    end
  end

  describe 'all' do
    subject { Vindicia::Repository::Product.all }

    before do
      stub_get('/products')
        .with({ query: { limit: 100 } })
        .to_return({
          :status => 200,
          :body => fixture('products_one'),
          :headers => { 'Content-Type': 'application/json' }
        })

      stub_get('/products')
        .with({ query: { limit: 100, starting_after: 1 } })
        .to_return({
          :status => 200,
          :body => fixture('products_two'),
          :headers => { 'Content-Type': 'application/json' }
        })

      stub_get('/products')
        .with({ query: { limit: 100, starting_after: 2 } })
        .to_return({
          :status => 200,
          :body => fixture('products_three'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'makes the right calls in the right order' do
      subject
      expect(a_get('/products').with({ query: { limit: 100 } })).to have_been_made.times(1)
      expect(a_get('/products').with({ query: { limit: 100, starting_after: 1 } })).to have_been_made.times(1)
      expect(a_get('/products').with({ query: { limit: 100, starting_after: 2 } })).to have_been_made.times(1)
    end

    it 'fetches 2 records' do
      expect(subject.count).to eql(2)
    end
  end
end
