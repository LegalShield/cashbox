require 'spec_helper'

describe 'Product' do
  before { Cashbox.test! }
  after { Cashbox.production! }

  describe 'first product' do
    subject do
      Cashbox::Product.first
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

    it { is_expected.to be_a(Cashbox::Product) }

    its(:vid)                  { is_expected.to eql('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa') }
    its(:id)                   { is_expected.to eql('1') }
    its(:created)              { is_expected.to eql(DateTime.parse('2017-02-03T13:46:27-08:00')) }
    its(:default_billing_plan) { is_expected.to be_a(Cashbox::BillingPlan)  }
    its(:descriptions)         { is_expected.to be_an(Array)  }
    its(:entitlements)         { is_expected.to be_an(Array)  }
    its(:prices)               { is_expected.to be_an(Array)  }
    its(:status)               { is_expected.to eql('Active')  }

    it 'descriptions are Cashbox::ProductDescription' do
      expect(subject.descriptions.first).to be_a(Cashbox::ProductDescription)
    end

    it 'entitlements are Cashbox::Entitlement' do
      expect(subject.entitlements.first).to be_a(Cashbox::Entitlement)
    end

    it 'product prices are Cashbox::ProductPrice' do
      expect(subject.prices.first).to be_a(Cashbox::ProductPrice)
    end
  end

  describe 'all' do
    subject { Cashbox::Product.all }

    let(:products_one) do
      hash = JSON.parse(fixture('products_one'))
      hash['data'] = 100.times.map { hash['data'][0] }
      hash['total_count'] = hash['data'].count
      hash.to_json
    end

    let(:products_two) do
      hash = JSON.parse(fixture('products_two'))
      hash['data'] = 100.times.map { hash['data'][0] }
      hash['total_count'] = hash['data'].count
      hash.to_json
    end

    before do
      stub_get('/products')
        .with({ query: { limit: 100 } })
        .to_return({
          :status => 200,
          :body => products_one,
          :headers => { 'Content-Type': 'application/json' }
        })

      stub_get('/products')
        .with({ query: { limit: 100, starting_after: 1 } })
        .to_return({
          :status => 200,
          :body => products_two,
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
      expect(subject.count).to eql(200)
    end
  end

  describe 'saving products' do
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
        id: '1',
        descriptions: [ product_description ],
        status: 'Active',
        default_billing_plan: billing_plan,
        entitlements: [ entitlement ],
        prices: [ price ]
      })
    end

    let!(:stub) do
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
        }).to_return({
          :status => 200,
          :body => fixture('product'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    before do
      product.save
    end

    it 'makes the correct api call' do
      expect(stub).to have_been_requested
    end

    it 'parses the response correctly' do
      expect(product.vid).to eq('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')
    end
  end
end
