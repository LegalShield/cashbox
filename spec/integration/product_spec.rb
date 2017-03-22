require 'spec_helper'

describe 'Product' do
  before { Vindicia.test!  }
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

    it 'product prices are Vindicia::Model::ProductPrice' do
      expect(subject.prices.first).to be_a(Vindicia::Model::ProductPrice)
    end
  end

  describe 'saving products' do
    let(:product_description) do
      Vindicia::Model::ProductDescription.new({
        language: 'EN',
        description: 'describy'
      })
    end

    let(:billing_plan_period) do
      Vindicia::Model::BillingPlanPeriod.new({
        type: 'Day',
        quantity: 1,
        cycles: 0
      })
    end

    let(:billing_plan) do
      Vindicia::Model::BillingPlan.new({
        id: '1',
        description: 'daily',
        status: 'Active',
        periods: [ billing_plan_period ]
      })
    end

    let(:entitlement) do
      Vindicia::Model::Entitlement.new({
        id: 'test-entitlement',
        description: 'described entitlement'
      })
    end

    let(:price) do
      Vindicia::Model::ProductPrice.new({
        amount: 9.99,
        currency: 'USD'
      })
    end

    let(:product) do
      Vindicia::Model::Product.new({
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

    it 'makes the appropriate request that is mocked above' do
      Vindicia::Repository::Product.save(product).body
    end
  end
end
