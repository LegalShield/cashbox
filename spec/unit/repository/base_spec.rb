require 'spec_helper'

describe Vindicia::Repository::Base do
  subject { Vindicia::Repository::Base }

  it 'parties with HTTParty' do
    expect(subject.ancestors).to include(HTTParty)
  end

  it 'is formated as json' do
    expect(subject.format).to eq :json
  end

  context 'making calls' do
    let(:repository)      { Vindicia::Repository::Base.new }
    let(:model)           { double('model') }
    let(:record)          { double('record') }
    let(:mapped_response) { double('mapped response', first: record) }
    let(:data)            { double('data') }
    let(:response)        { double('response', to_h: data) }

    before do
      allow(Vindicia::ResponseMapper::Base).to receive(:map).with(data).and_return(mapped_response)
    end

    describe 'shared' do
      before do
        Vindicia.username = 'u'
        Vindicia.password = 'p'

        allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ basic_auth: { username: 'u', password: 'p' } })).and_return(response)
      end

      it 'adds the correct authentication' do
        repository.all
        expect(Vindicia::Repository::Base).to have_received(:get).with(kind_of(String), hash_including({ basic_auth: { username: 'u', password: 'p' } }))
      end

      it 'calls the correct list route' do
        repository.all
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases', kind_of(Hash))
      end

      it 'calls the correct show route' do
        repository.find(1)
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases/1', kind_of(Hash))
      end
    end

    describe '#where' do
      let(:call_response) { repository.where({ name: 'Jon' }) }

      before do
        allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { limit: 500, name: 'Jon' } })).and_return(response)
        call_response
      end

      it 'calls the correct list route' do
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases', kind_of(Hash))
      end

      it 'accepts query params' do
        expect(Vindicia::Repository::Base).to have_received(:get).with(kind_of(String), hash_including({ query: { limit: 500, name: 'Jon' } }))
      end

      it 'maps the response correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(data)
      end

      it 'returns the mapped response' do
        expect(call_response).to eql(mapped_response)
      end
    end

    describe '#all' do
      let(:call_response) { repository.all }

      before do
        allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { } })).and_return(response)
        call_response
      end

      it 'calls the correct list route' do
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases', kind_of(Hash))
      end

      it 'makes a calls for all records' do
        expect(Vindicia::Repository::Base).to have_received(:get).with(kind_of(String), hash_including({ query: { } }))
      end

      it 'maps the response correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(data)
      end

      it 'returns the mapped response' do
        expect(call_response).to eql(mapped_response)
      end
    end

    describe '#first' do
      let(:call_response) { repository.first }

      before do
        allow(Vindicia::ResponseMapper::Base).to receive(:map).with(data).and_return(mapped_response)
        allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { limit: 1 } })).and_return(response)
        call_response
      end

      it 'calls the correct list route' do
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases', kind_of(Hash))
      end

      it 'sets limit to 1' do
        expect(Vindicia::Repository::Base).to have_received(:get).with(kind_of(String), hash_including({ query: { limit: 1 } }))
      end

      it 'parses the response correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(data)
      end

      it 'returns the correct response' do
        expect(call_response).to eql(record)
      end
    end

    describe '#find' do
      context 'success' do
        let(:call_response) { repository.find(1) }

        before do
          allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { } })).and_return(response)
          call_response
        end

        it 'calls the correct show route' do
          expect(Vindicia::Repository::Base).to have_received(:get).with('/bases/1', kind_of(Hash))
        end

        it 'parses the response correctly' do
          expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(data)
        end

        it 'returns the correct response' do
          expect(call_response).to eql(mapped_response)
        end
      end

      context 'failure' do
        it 'throws an error if an id is not supplied' do
          expect( -> { repository.find(nil) }).to raise_exception(ArgumentError)
        end
      end
    end

    describe '#save' do
      let(:mapped_request_to_json) { double('mapped request to json') }
      let(:mapped_request)         { double('mapped request', to_json: mapped_request_to_json ) }
      let(:call_response)          { repository.save(model) }

      before do
        allow(Vindicia::RequestMapper::Base).to receive(:map).with(model).and_return(mapped_request)
      end

      context 'persisted record' do
        before do
          allow(model).to receive(:id) { 123 }
          allow(Vindicia::Repository::Base).to receive(:post).with('/bases/123', hash_including({ body: mapped_request_to_json })).and_return(response)
          call_response
        end

        it 'checks the id of the model' do
          expect(model).to have_received(:id)
        end

        it 'calls the correct update route' do
          expect(Vindicia::Repository::Base).to have_received(:post).with('/bases/123', hash_including({ body: mapped_request_to_json }))
        end

        it 'delgates request mapping correctly' do
          expect(Vindicia::RequestMapper::Base).to have_received(:map).with(model)
        end

        it 'delegates response mapping correctly' do
          expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(data)
        end

        it 'returns the mapped response' do
          expect(call_response).to eql(mapped_response)
        end
      end

      context 'unpersisted record' do
        before do
          allow(model).to receive(:id) { nil }
          allow(Vindicia::Repository::Base).to receive(:post).with('/bases', hash_including({ body: mapped_request_to_json })).and_return(response)
          call_response
        end

        it 'checks the id of the model' do
          expect(model).to have_received(:id)
        end

        it 'calls the correct create route' do
          expect(Vindicia::Repository::Base).to have_received(:post).with('/bases', hash_including({ body: mapped_request_to_json }))
        end

        it 'delgates request mapping correctly' do
          expect(Vindicia::RequestMapper::Base).to have_received(:map).with(model)
        end

        it 'delegates response mapping correctly' do
          expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(data)
        end

        it 'returns the mapped response' do
          expect(call_response).to eql(mapped_response)
        end
      end
    end
  end
end
