require 'spec_helper'

describe Vindicia::Repository::Base do
  before do
    Vindicia.username = 'u'
    Vindicia.password = 'p'
  end

  context 'config' do
    subject { Vindicia::Repository::Base }

    it 'parties with HTTParty' do
      expect(subject.new).to be_a(HTTParty)
    end

    it 'is formated as json' do
      expect(subject.format).to eq :json
    end
  end

  context 'making calls' do
    subject        { Vindicia::Repository::Base.new }
    let(:record)   { double('record') }
    let(:data)     { double('data', first: record, to_h: record) }
    let(:response) { double('response', to_h: data, first: data) }
    let(:model)    { double('model') }

    before do
      allow(Vindicia::ResponseMapper::Base).to receive(:map).with(data) { [] }
    end

    describe 'shared' do
      before do
        allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ basic_auth: { username: 'u', password: 'p' } })).and_return(response)
      end

      it 'adds the correct authentication' do
        subject.all
        expect(Vindicia::Repository::Base).to have_received(:get).with(kind_of(String), hash_including({ basic_auth: { username: 'u', password: 'p' } }))
      end

      it 'calls the correct list route' do
        subject.all
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases', kind_of(Hash))
      end

      it 'calls the correct show route' do
        subject.find(1)
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases/1', kind_of(Hash))
      end
    end

    describe '#where' do
      before do
        allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { limit: 500, name: 'Jon' } })).and_return(response)
        subject.where({ name: 'Jon' })
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
    end

    describe '#all' do
      before do allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { } })).and_return(response)
        subject.all
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
    end

    describe '#first' do
      before do
        allow(Vindicia::ResponseMapper::Base).to receive(:map).with(record)
        allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { limit: 1 } })).and_return(response)
        subject.first
      end

      it 'calls the correct list route' do
        expect(Vindicia::Repository::Base).to have_received(:get).with('/bases', kind_of(Hash))
      end

      it 'sets limit to 1' do
        expect(Vindicia::Repository::Base).to have_received(:get).with(kind_of(String), hash_including({ query: { limit: 1 } }))
      end

      it 'parses the response correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(record)
      end
    end

    describe '#find' do
      context 'success' do
        before do
          allow(Vindicia::Repository::Base).to receive(:get).with(kind_of(String), hash_including({ query: { } })).and_return(response)
          subject.find(1)
        end

        it 'calls the correct show route' do
          expect(Vindicia::Repository::Base).to have_received(:get).with('/bases/1', kind_of(Hash))
        end

        it 'parses the response correctly' do
          expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(data)
        end
      end

      context 'failure' do
        it 'throws an error if an id is not supplied' do
          expect( -> { subject.find(nil) }).to raise_exception(ArgumentError)
        end
      end
    end

    describe '#save' do
      let(:mapped_request_to_json) { double('mapped request to json') }
      let(:mapped_request) { double('mapped request', to_json: mapped_request_to_json ) }

      before do
        allow(Vindicia::RequestMapper::Base).to receive(:map).with(model).and_return(mapped_request)
      end

      context 'persisted record' do
        before do
          allow(model).to receive(:id) { 123 }
          allow(Vindicia::Repository::Base).to receive(:post).with('/bases/123', hash_including({ body: mapped_request_to_json })).and_return(response)
          subject.save(model)
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
      end

      context 'unpersisted record' do
        before do
          allow(model).to receive(:id) { nil }
          allow(Vindicia::Repository::Base).to receive(:post).with('/bases', hash_including({ body: mapped_request_to_json })).and_return(response)
          subject.save(model)
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
      end
    end
  end
end
