require 'spec_helper'

describe 'Product' do
  before { Vindicia.test! }
  after { Vindicia.production! }

  describe 'first product' do
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

    it { is_expected.to be_a(Vindicia::Product) }

    its(:vid)                  { is_expected.to eql('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa') }
    its(:id)                   { is_expected.to eql('1') }
    its(:created)              { is_expected.to eql(DateTime.parse('2017-02-03T13:46:27-08:00')) }
    its(:default_billing_plan) { is_expected.to be_a(Vindicia::BillingPlan)  }
    its(:descriptions)         { is_expected.to be_an(Array)  }
    its(:entitlements)         { is_expected.to be_an(Array)  }
    its(:prices)               { is_expected.to be_an(Array)  }
    its(:status)               { is_expected.to eql('Active')  }

    it 'descriptions are Vindicia::ProductDescription' do
      expect(subject.descriptions.first).to be_a(Vindicia::ProductDescription)
    end

    it 'entitlements are Vindicia::Entitlement' do
      expect(subject.entitlements.first).to be_a(Vindicia::Entitlement)
    end

    it 'product prices are Vindicia::ProductPrice' do
      expect(subject.prices.first).to be_a(Vindicia::ProductPrice)
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

    it 'makes the right calls' do
      subject
      expect(a_get('/products').with({ query: { limit: 100 } })).to have_been_made.times(1)
      expect(a_get('/products').with({ query: { limit: 100, starting_after: 1 } })).to have_been_made.times(1)
      expect(a_get('/products').with({ query: { limit: 100, starting_after: 2 } })).to have_been_made.times(1)
    end

    it 'fetches 2 records' do
      expect(subject.count).to eql(2)
    end
  end

  describe 'saving products' do
    let(:product_description) do
      Vindicia::ProductDescription.new({
        language: 'EN',
        description: 'describy'
      })
    end

    let(:billing_plan_period) do
      Vindicia::BillingPlanPeriod.new({
        type: 'Day',
        quantity: 1,
        cycles: 0
      })
    end

    let(:billing_plan) do
      Vindicia::BillingPlan.new({
        id: '1',
        description: 'daily',
        status: 'Active',
        periods: [ billing_plan_period ]
      })
    end

    let(:entitlement) do
      Vindicia::Entitlement.new({
        id: 'test-entitlement',
        description: 'described entitlement'
      })
    end

    let(:price) do
      Vindicia::ProductPrice.new({
        amount: 9.99,
        currency: 'USD'
      })
    end

    let(:product) do
      Vindicia::Product.new({
        id: '1',
        descriptions: [ product_description ],
        status: 'Active',
        default_billing_plan: billing_plan,
        entitlements: [ entitlement ],
        prices: [ price ]
      })
    end

    before do
      stub_post('/products')
        .with({
          body: {
            object: 'Product',
            id: '1',
            descriptions: [ { object: 'ProductDescription', language: 'EN', description: 'describy' } ],
            status: 'Active',
            default_billing_plan: {
              object: 'BillingPlan',
              id: '1',
              description: 'daily',
              status: 'Active',
              periods: [ { object: 'BillingPlanPeriod', type: 'Day', quantity: 1, cycles: 0 } ]
            },
            entitlements: [ { object: 'Entitlement', id: 'test-entitlement', description: 'described entitlement' } ],
            prices: [ { object: 'ProductPrice', amount: 9.99, currency: 'USD' } ],
          }.to_json
        })
        .to_return({
          :status => 200,
          :body => fixture('product'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'makes the correct api call' do
      Vindicia::Repository::Product.save(product)
    end

    it 'parses the response correctly' do
      result = Vindicia::Repository::Product.save(product)
      expect(result).to be_a(Vindicia::Product)
      expect(result).not_to eq(product)
    end
  end
end
