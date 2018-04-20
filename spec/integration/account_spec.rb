require 'spec_helper'

describe 'Account' do
  before { Cashbox.test! }
  after { Cashbox.production! }

  describe 'creating an account' do
    let!(:stub) do
      stub_post('/accounts')
        .with({ body: { object: 'Account', id: 1 }.to_json })
        .to_return({
          :status => 200,
          :body => fixture('account'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'makes the correct call to create' do
      account = Cashbox::Account.new({ id: 1 })
      account.save
      expect(stub).to have_been_requested
    end
  end

  describe 'updating an account' do
    let!(:stub) do
      stub_post('/accounts')
        .with({ body: { object: 'Account', id: 1 }.to_json })
        .to_return({
          :status => 200,
          :body => fixture('account'),
          :headers => { 'Content-Type': 'application/json' }
        })

      account = JSON.parse(fixture('account'))
      account['payment_methods'] = account['payment_methods']['data']

      stub_post("/accounts/#{account['vid']}")
        .with({ body: account.to_json })
        .to_return({
          :status => 200,
          :body => fixture('account'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'makes the correct call to update' do
      account = Cashbox::Account.new({ id: 1 })
      account.save
      account.save
      expect(stub).to have_been_requested
    end
  end

  describe 'throwing errors' do
    let!(:stub) do
      stub_post('/accounts')
        .with({ body: { object: 'Account', id: 1 }.to_json })
        .to_return({
          :status => 200,
          :body => fixture('error'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'throws the error correctly' do
      account = Cashbox::Account.new({ id: 1 })
      expect { account.save }.to raise_error(Cashbox::Error, "No id (unique identifier) specified for Account.")
      expect(stub).to have_been_requested
    end
  end
end
