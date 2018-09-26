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
        .with({ body: json.to_json })
        .to_return({
          :status => 200,
          :body => fixture('account'),
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

  describe 'updating the payment method on an account' do
    let(:account) { Cashbox::Account.new({ vid: '1' }) }
    let(:payment_method) { Cashbox::PaymentMethod.new }

    let!(:stub) do
      stub_post('/accounts/1?update_behavior=CatchUp&replace_on_all_subscriptions=0&ignore_avs=0&ignore_cvn=0')
        .with({
          body: {
            id: '1',
            payment_methods: {
              object: "List",
              data: [payment_method]
            }
          }.to_json})
        .to_return({
          :status => 200,
          :body => fixture('payment_method'),
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    before do
      account.update_payment(payment_method)
    end

    it 'makes the correct api call' do
      expect(stub).to have_been_requested
    end
  end
end
