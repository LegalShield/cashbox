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
    let(:json) do
      json = JSON.parse(fixture('account'))
      json['payment_methods'] = json['payment_methods']['data']
      json
    end

    let!(:stub) do
      stub_post("/accounts/#{json['vid']}")
        .with({ body: json })
        .to_return({
          :status => 200,
          :body => json.to_json,
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'makes the correct call to update' do
      account = Cashbox::Account.new(json)
      account.save
      expect(stub).to have_been_requested
    end
  end

  describe 'handling a returned error' do
    let!(:stub) do
      stub_post('/accounts')
        .with({ body: { object: 'Account', id: 1 }.to_json })
        .to_return({
          :status => 200,
          :body => fixture('error'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    let(:account) { Cashbox::Account.new({ id: 1 }) }

    it 'returns false' do
      expect(account.save).to be false
    end

    it 'throws the error correctly' do
      expect {
        account.save!
      }.to raise_error(Cashbox::Error, "No id (unique identifier) specified for Account.")
    end

    it 'makes the correct api call' do
      account.save
      expect(stub).to have_been_requested
    end
  end

  describe 'searching for an account' do
    let(:json) { JSON.parse(fixture('account')) }

    let!(:stub_find) do
      stub_get("/accounts/#{json['vid']}")
        .to_return({
          :status => 200,
          :body => fixture('account'),
          :headers => { 'Content-Type': 'application/json' }
      })
    end

    let!(:stub_where) do
      stub_get("/accounts?limit=100&vid=#{json['vid']}")
        .to_return({
          :status => 200,
          :body => fixture('account'),
          :headers => { 'Content-Type': 'application/json' }
      })
    end

    let!(:stub_first) do
      stub_get("/accounts?limit=1")
        .to_return({
          :status => 200,
          :body => fixture('account'),
          :headers => { 'Content-Type': 'application/json' }
      })
    end

    let!(:stub_all) do
      stub_get("/accounts?limit=100")
        .to_return({
          :status => 200,
          :body => fixture('account'),
          :headers => { 'Content-Type': 'application/json' }
      })
    end

    it 'makes the correct call to find' do
      Cashbox::Account.find(json['vid'])
      expect(stub_find).to have_been_requested
    end

    it 'makes the correct call to where' do
      Cashbox::Account.where(vid: json['vid'])
      expect(stub_where).to have_been_requested
    end

    it 'makes the correct call to first' do
      Cashbox::Account.first
      expect(stub_first).to have_been_requested
    end

    it 'makes the correct call to all' do
      Cashbox::Account.all
      expect(stub_all).to have_been_requested
    end
  end
end
