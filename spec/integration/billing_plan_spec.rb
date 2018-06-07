require 'spec_helper'

describe 'BillingPlan' do
  before { Cashbox.test! }
  after { Cashbox.production! }

  describe 'first product' do
    subject do
      Cashbox::BillingPlan.first
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

    it { is_expected.to be_a(Cashbox::BillingPlan) }

  end
end
