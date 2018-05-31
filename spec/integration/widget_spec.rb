require 'spec_helper'

describe 'Widget' do
  class self::Widget < Cashbox::Model
    include Cashbox::Rest::ReadWrite
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
      let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' }.to_json }

      let!(:stub) do
        stub_post('/widgets')
          .with({ body: { id: 1, name: 'my-widget' }.to_json })
          .to_return(api_response(body))
      end

      before do
        expect(subject.vid).to be_nil
        subject.save
      end

      it 'calls the create endpoint correctly' do
        expect(subject.vid).to eql(1)
        expect(stub).to have_been_requested
      end
    end

    context 'update a widget' do
      subject { self.class::Widget.new({ vid: 1, id: 1, name: 'my-widget' }) }
      let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' }.to_json }

      let!(:stub) do
        stub_post('/widgets/1')
          .with({ body: { vid: 1, id: 1, name: 'my-widget' }.to_json })
          .to_return(api_response(body))
      end

      before do
        subject.save
      end

      it 'calls the update endpoint correctly' do
        expect(stub).to have_been_requested
      end
    end
  end

  describe '.find' do
    subject { self.class::Widget }
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' }.to_json }

    let!(:stub) do
      stub_get('/widgets/1').to_return(api_response(body))
    end

    before do
      subject.find(1)
    end

    it 'calls the show endpoint correctly' do
      expect(stub).to have_been_requested
    end
  end

  describe '.where' do
    subject { self.class::Widget }

    context 'with property params' do
      let(:body) { { 'object' => 'List', 'data' => [ { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' } ] }.to_json }

      it 'makes the correct request' do
        stub = stub_get('/widgets')
          .with({ query: { name: 'my-widget', limit: 100 } })
          .to_return(api_response(body))

        subject.where({ name: 'my-widget' })

        expect(stub).to have_been_requested
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

      let(:second_body) { {
        'object' => 'List',
        'data' => [ { 'object' => 'Widget', 'vid' => 2, 'id' => 2, 'name' => 'my-widget' } ],
        'next' => nil,
        'previous' => '/widgets?limit=100&ending_before=2&name=my-widget'
      }.to_json }

      it 'makes the correct request' do
        first_stub = stub_get('/widgets')
          .with({ query: { name: 'my-widget', limit: 100 } })
          .to_return(api_response(first_body))

        second_stub = stub_get('/widgets')
          .with({ query: { name: 'my-widget', limit: 100, starting_after: 1 } })
          .to_return(api_response(second_body))

        subject.where({ name: 'my-widget', limit: 120 })

        expect(first_stub).to have_been_requested
        expect(second_stub).to have_been_requested
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

    let(:second_body) { {
      'object' => 'List',
      'data' => [ { 'object' => 'Widget', 'vid' => 2, 'id' => 2, 'name' => 'my-widget' } ],
      'next' => '/widgets?limit=100&starting_after=2',
      'previous' => '/widgets?limit=100&ending_before=2'
    }.to_json }

    let(:third_body) { {
      'object' => 'List',
      'data' => [ { 'object' => 'Widget', 'vid' => 3, 'id' => 3, 'name' => 'my-widget' } ],
      'next' => nil,
      'previous' => '/widgets?limit=100&ending_before=3'
    }.to_json }

    it 'makes requests until there are no more records' do
      first_stub  = stub_get('/widgets')
        .with({ query: { limit: 100 } })
        .to_return(api_response(first_body))
      second_stub = stub_get('/widgets')
        .with({ query: { limit: 100, starting_after: 1 } })
        .to_return(api_response(second_body))
      third_stub  = stub_get('/widgets')
        .with({ query: { limit: 100, starting_after: 2 } })
        .to_return(api_response(third_body))

      subject.all

      expect(first_stub).to have_been_requested
      expect(second_stub).to have_been_requested
      expect(third_stub).to have_been_requested
    end
  end

  describe '.first' do
    subject { self.class::Widget }

    let(:body) { {
      'object' => 'List',
      'data' => [ { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'my-widget' } ],
      'next' => '/widgets?limit=1&starting_after=1',
      'previous' => '/widgets?limit=1&ending_before=1'
    }.to_json }

    it 'makes a request with limit 1 then returns the single record' do
      stub = stub_get('/widgets')
        .with({ query: { limit: 1 } })
        .to_return(api_response(body))

      subject.first

      expect(stub).to have_been_requested
    end
  end
end
