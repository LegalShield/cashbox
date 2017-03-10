require 'spec_helper'

describe 'Product' do
  before do
    Vindicia.test!
  end

  describe 'first transaction' do
    subject do
      Vindicia::Repository::Transaction.first
    end

    before do
      stub_get('/transactions')
        .with({ query: { limit: 1 } })
        .to_return(:status => 200, :body => fixture('transactions'), :headers => { 'Content-Type': 'application/json' })
    end

    it { is_expected.to be_a(Vindicia::Model::Transaction) }

    its(:vid)          { is_expected.to eql('00df553ba17a0cde2275e278628fd6b7f2d8b067') }
    its(:id)           { is_expected.to eql('LEGALSHI00000684') }
    its(:created)      { is_expected.to eql(DateTime.parse('2017-02-11T00:01:35-08:00')) }
    its(:amount)       { is_expected.to eql(10.71) }
    its(:currency)     { is_expected.to eql('USD') }
    its(:account)      { is_expected.to be_a(Vindicia::Model::Account)  }
    its(:subscription) { is_expected.to be_a(Vindicia::Model::Subscription)  }

    #its(:descriptions)         { is_expected.to be_an(Array)  }
    #its(:entitlements)         { is_expected.to be_an(Array)  }
    #its(:prices)               { is_expected.to be_an(Array)  }
    #its(:status)               { is_expected.to eql('Active')  }

    #it 'descriptions are Vindicia::Model::ProductDescription' do
      #expect(subject.descriptions.first).to be_a(Vindicia::Model::ProductDescription)
    #end

    #it 'entitlements are Vindicia::Model::Entitlement' do
      #expect(subject.entitlements.first).to be_a(Vindicia::Model::Entitlement)
    #end

    #it 'product prices are Vindicia::Model::ProductPrice' do
      #expect(subject.prices.first).to be_a(Vindicia::Model::ProductPrice)
    #end
  end
end
