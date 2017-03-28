require 'spec_helper'

describe 'BillingPlan' do
  before { Vindicia.test! }
  after { Vindicia.production! }

  describe 'first product' do
    subject do
      Vindicia::BillingPlan.first
    end

    before do
      stub_get('/billing_plans')
        .with({ query: { limit: 1 } })
        .to_return({
          :status => 200,
          :body => fixture('billing_plans'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it { is_expected.to be_a(Vindicia::BillingPlan) }
  end
end
