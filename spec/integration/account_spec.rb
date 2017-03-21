require 'spec_helper'

describe 'Account' do
  before { Vindicia.test!  }
  after { Vindicia.production! }

  describe 'count' do

    before do
      stub_get('/accounts')
        .with({ query: { limit: 0 } })
        .to_return({
          :status => 200,
          :body => fixture('account_empty'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'makes a call to get the total count' do
      #query = Hashie::Clash.new.language('SP')
      #query = Vindicia::Query.where({ language: 'SP' })
      #Vindicia::Repository::Account.new(query).count
      #expect(a_get('/accounts')).to have_been_made
    end
  end
end
