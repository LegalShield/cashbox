require 'spec_helper'

describe 'Widget' do
  class self::Widget < Cashbox::Model
    include Cashbox::Rest::ReadWrite
    include Cashbox::Rest::Cancel
    include Cashbox::Rest::Disentitle
    include Cashbox::Rest::Archive

    property :vid
    property :id
    property :name
  end

  def api_response(body)
    { :status => 200, :body => body, :headers => headers }
  end

  let(:headers) { { 'Content-Type': 'application/json' } }

  describe '#save' do
    context 'create a widget' do
      subject { self.class::Widget.new({ id: 1, name: 'my-widget' }) }
      let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'your-widget' }.to_json }

      let!(:stub) do
        stub_post('/widgets')
          .with({ body: { id: 1, name: 'my-widget' }.to_json })
          .to_return(api_response(body))
      end

      before { subject.save }

      it 'updates the instance with the response' do
        expect(subject.vid).to eql(1)
        expect(subject.name).to eql('your-widget')
      end

      it 'calls the create endpoint correctly' do
        expect(stub).to have_been_requested
      end
    end

    context 'update a widget' do
      subject { self.class::Widget.new({ vid: 1, id: 1, name: 'my-widget' }) }
      let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'the-widget' }.to_json }

      let!(:stub) do
        stub_post('/widgets/1')
          .with({ body: { vid: 1, id: 1, name: 'my-widget' }.to_json })
          .to_return(api_response(body))
      end

      before do
        subject.save
      end

      it 'updates the instance with the response' do
        expect(subject.name).to eql('the-widget')
      end

      it 'calls the update endpoint correctly' do
        expect(stub).to have_been_requested
      end
    end
  end

  describe '.find' do
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' }.to_json }
    let!(:stub) { stub_get('/widgets/1').to_return(api_response(body)) }
    let!(:instance) { self.class::Widget.find(1) }

    it 'returns an instance populated with data from the response' do
      expect(instance.vid).to eql(1)
      expect(instance.id).to eql(1)
      expect(instance.name).to eql('my-widget')
    end

    it 'calls the show endpoint correctly' do
      expect(stub).to have_been_requested
    end
  end

  describe '.where' do
    subject { self.class::Widget }

    context 'with property params' do
      let(:body) { { 'object' => 'List', 'data' => [ { 'object' => 'Widget', 'vid' => 2, 'id' => 6, 'name' => 'tony' } ] }.to_json }
      let!(:stub) { stub_get('/widgets').with({ query: { name: 'my-widget', limit: 100 } }).to_return(api_response(body)) }
      let!(:instances) { subject.where({ name: 'my-widget' }) }
      let(:instance) { instances[0] }

      it 'makes the correct request' do
        expect(stub).to have_been_requested
      end

      it 'returns an array' do
        expect(instances).to be_an(Array)
        expect(instances.size).to eql(1)
      end

      it 'initialize the correct class' do
        expect(instance).to be_an(self.class::Widget)
      end

      it 'populates the correct data' do
        expect(instance.vid).to eql(2)
        expect(instance.id).to eql(6)
        expect(instance.name).to eql('tony')
      end
    end

    context 'when limiting results' do
      let(:body) { { 'object' => 'List', 'data' => [ { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' } ] }.to_json }

      it 'makes the correct request' do
        stub = stub_get('/widgets')
          .with({ query: { name: 'my-widget', limit: 10 } })
          .to_return(api_response(body))

        subject.where({ name: 'my-widget', limit: 10 })

        expect(stub).to have_been_requested
      end
    end

    context 'when asking for more than the max limit' do
      let(:first_body) { {
        'object' => 'List',
        'data' => [ { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' } ],
        'next' => '/widgets?limit=100&starting_after=1&name=my-widget',
        'previous' => '/widgets?limit=100&ending_before=1&name=my-widget'
      }.to_json }

      let!(:first_stub) do
        stub_get('/widgets').with({ query: { name: 'my-widget', limit: 100 } }).to_return(api_response(first_body))
      end

      let(:second_body) { {
        'object' => 'List',
        'data' => [ { 'object' => 'Widget', 'vid' => 2, 'id' => 2, 'name' => 'my-widget' } ],
        'next' => nil,
        'previous' => '/widgets?limit=100&ending_before=2&name=my-widget'
      }.to_json }

      let!(:second_stub) do
        stub_get('/widgets').with({ query: { name: 'my-widget', limit: 100, starting_after: 1 } }).to_return(api_response(second_body))
      end

      let!(:results) { subject.where({ name: 'my-widget', limit: 120 }) }

      it 'makes the correct request' do
        expect(first_stub).to have_been_requested
        expect(second_stub).to have_been_requested
      end

      it 'merges the results from the multiple requests into a single results array' do
        expect(results.size).to eql(2)
      end
    end
  end

  describe '.all' do
    subject { self.class::Widget }

    let(:first_body) { {
      'object' => 'List',
      'data' => [ { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' } ],
      'next' => '/widgets?limit=100&starting_after=1',
      'previous' => '/widgets?limit=100&ending_before=1'
    }.to_json }

    let!(:first_stub) {
      stub_get('/widgets').with({ query: { limit: 100 } }).to_return(api_response(first_body))
    }

    let(:second_body) { {
      'object' => 'List',
      'data' => [ { 'object' => 'Widget', 'vid' => 2, 'id' => 2, 'name' => 'my-widget' } ],
      'next' => '/widgets?limit=100&starting_after=2',
      'previous' => '/widgets?limit=100&ending_before=2'
    }.to_json }

    let!(:second_stub) {
      stub_get('/widgets').with({ query: { limit: 100, starting_after: 1 } }).to_return(api_response(second_body))
    }

    let(:third_body) { {
      'object' => 'List',
      'data' => [ { 'object' => 'Widget', 'vid' => 3, 'id' => 3, 'name' => 'my-widget' } ],
      'next' => nil,
      'previous' => '/widgets?limit=100&ending_before=3'
    }.to_json }

    let!(:third_stub) {
      stub_get('/widgets').with({ query: { limit: 100, starting_after: 2 } }).to_return(api_response(third_body))
    }

    before { subject.all }

    it 'makes requests until there are no more records' do
      expect(first_stub).to have_been_requested
      expect(second_stub).to have_been_requested
      expect(third_stub).to have_been_requested
    end
  end

  describe '.first' do
    subject {  }

    let(:body) { {
      'object' => 'List',
      'data' => [ { 'object' => 'Widget', 'vid' => 15, 'id' => 1, 'name' => 'my-widget' } ],
      'next' => '/widgets?limit=1&starting_after=1',
      'previous' => '/widgets?limit=1&ending_before=1'
    }.to_json }

    let!(:stub) {
      stub_get('/widgets').with({ query: { limit: 1 } }).to_return(api_response(body))
    }

    let!(:subject) { self.class::Widget.first }

    it 'makes a request with limit 1 then returns the single record' do
      expect(stub).to have_been_requested
    end

    it 'returns and instance that is the correct class' do
      expect(subject).to be_a(self.class::Widget)
    end

    its(:name) { is_expected.to eql('my-widget') }
    its(:id)   { is_expected.to eql(1) }
    its(:vid)  { is_expected.to eql(15) }
  end

  describe '#cancel' do
    subject { self.class::Widget.new({ vid: 'vid', id: 1, name: 'my-widget' }) }
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'your-widget' }.to_json }
    let!(:stub) { stub_post('/widgets/vid/actions/cancel').to_return(api_response(body)) }

    before { subject.cancel }

    it 'makes the correct api call to cancel' do
      expect(stub).to have_been_requested
    end
  end

  describe '#disentitle' do
    subject { self.class::Widget.new({ vid: 'vid', id: 1, name: 'my-widget' }) }
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'your-widget' }.to_json }
    let!(:stub) { stub_post('/widgets/vid/actions/cancel').with({ body: { disentitle: 'Yes' }.to_json }).to_return(api_response(body)) }

    before { subject.disentitle }

    it 'makes the correct api call to disentitle' do
      expect(stub).to have_been_requested
    end
  end

  describe '#archive' do
    subject { self.class::Widget.new({ vid: 'vid', id: 1, name: 'my-widget' }) }
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'your-widget' }.to_json }
    let!(:stub) { stub_post('/widgets/vid').with({ body: { active: false }.to_json }).to_return(api_response(body)) }

    before { subject.archive }

    it 'makes the correct api call to archive' do
      expect(stub).to have_been_requested
    end
  end
end
