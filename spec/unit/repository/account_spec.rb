require 'spec_helper'

describe Vindicia::Repository::Base do
  context 'making calls' do

    let(:repository) { Vindicia::Repository::Base }
    let(:model)      { double('model') }
    let(:record)     { double('record') }
    let(:data)       { double('data') }
    let(:response)   { double('response', to_h: data, body: [ record ]) }
    let(:request)    { double('request', perform: response) }

    before do
      Vindicia.username = 'u'
      Vindicia.password = 'p'

      allow(Vindicia::Response).to receive(:new).with(request).and_return(response)
    end

    shared_examples_for 'a get request' do
      subject { Vindicia::Request }
      it { is_expected.to have_received(:new).with(:get, any_args) }
    end

    shared_examples_for 'an index route' do
      subject { Vindicia::Request }
      it { is_expected.to have_received(:new).with(anything, '/bases', any_args) }
    end

    shared_examples_for 'a show route' do
      subject { Vindicia::Request }
      it { is_expected.to have_received(:new).with(anything, '/bases/1') }
    end

    shared_examples_for 'creating a response' do
      subject { Vindicia::Response }
      it { is_expected.to have_received(:new).with(request) }
    end

    shared_examples_for 'returning a response' do
      it 'returns the correct response' do
        expect(call_response).to eql(response)
      end
    end

    describe 'shared' do
      context 'index' do
        before do
          allow(Vindicia::Request).to receive(:new).with(:get, '/bases', { query: { limit: 100 } }).and_return(request)
        end

        let!(:call_response) { repository.all }

        it_behaves_like('a get request')
        it_behaves_like('an index route')
        it_behaves_like('creating a response')
        it_behaves_like('returning a response')
      end

      context 'show' do
        before do
          allow(Vindicia::Request).to receive(:new).with(:get, '/bases/1').and_return(request)
        end

        let!(:call_response) { repository.find(1) }

        it_behaves_like('a show route')
      end
    end

    describe '#where' do
      before do
        allow(Vindicia::Request).to receive(:new).with(:get, '/bases', { query: { limit: 100, name: 'Jon' } }).and_return(request)
      end

      let!(:call_response) { repository.where({ name: 'Jon' }) }

      it_behaves_like('a get request')
      it_behaves_like('an index route')
      it_behaves_like('creating a response')
      it_behaves_like('returning a response')

      it 'calls with the correct query' do
        expect(Vindicia::Request).to have_received(:new).with(kind_of(Symbol), kind_of(String), { query: { limit: 100, name: 'Jon' } })
      end
    end

    describe '#all' do
      before do
        allow(Vindicia::Request).to receive(:new).with(:get, '/bases', { query: { limit: 100 } }).and_return(request)
      end

      let!(:call_response) { repository.all }

      it_behaves_like('a get request')
      it_behaves_like('an index route')
      it_behaves_like('creating a response')
      it_behaves_like('returning a response')
    end

    describe '#find' do
      context 'success' do
        before do
          allow(Vindicia::Request).to receive(:new).with(:get, '/bases/1').and_return(request)
        end

        let!(:call_response) { repository.find(1) }

        it_behaves_like('a get request')
        it_behaves_like('a show route')
        it_behaves_like('creating a response')
        it_behaves_like('returning a response')
      end

      context 'failure' do
        it 'throws an error if an id is not supplied' do
          expect( -> { repository.find(nil) }).to raise_exception(ArgumentError)
        end
      end
    end

    describe '#first' do
      before do
        allow(Vindicia::Request).to receive(:new).with(:get, '/bases', { query: { limit: 1 } }).and_return(request)
      end

      let!(:call_response) { repository.first }

      it_behaves_like('a get request')
      it_behaves_like('an index route')
      it_behaves_like('creating a response')

      it 'returns the correct response' do
        expect(call_response).to eql(record)
      end

      it 'sets limit to 1' do
        expect(Vindicia::Request).to have_received(:new).with(anything, anything, { query: { limit: 1 } })
      end
    end

    #describe '#save' do
      #let(:mapped_request_to_json) { double('mapped request to json') }
      #let(:mapped_request)         { double('mapped request', to_json: mapped_request_to_json ) }
      #let(:call_response)          { repository.save(model) }

      #before do
        #allow(Vindicia::RequestMapper::Base).to receive(:map).with(model).and_return(mapped_request)
      #end

      #context 'persisted record' do
        #before do
          #allow(model).to receive(:id) { 123 }
          #allow(Vindicia::Repository::Base).to receive(:post).with('/bases/123', hash_including({ body: mapped_request_to_json })).and_return(response)
          #call_response
        #end

        #it 'checks the id of the model' do
          #expect(model).to have_received(:id)
        #end

        #it 'calls the correct update route' do
          #expect(Vindicia::Repository::Base).to have_received(:post).with('/bases/123', hash_including({ body: mapped_request_to_json }))
        #end

        #it 'delgates request mapping correctly' do
          #expect(Vindicia::RequestMapper::Base).to have_received(:map).with(model)
        #end

        #it 'delegates response mapping correctly' do
          #expect(Vindicia::Response).to have_received(:new).with(data)
        #end

        #it 'returns the mapped response' do
          #expect(call_response).to eql(mapped_response)
        #end
      #end

      #context 'unpersisted record' do
        #before do
          #allow(model).to receive(:id) { nil }
          #allow(Vindicia::Repository::Base).to receive(:post).with('/bases', hash_including({ body: mapped_request_to_json })).and_return(response)
          #call_response
        #end

        #it 'checks the id of the model' do
          #expect(model).to have_received(:id)
        #end

        #it 'calls the correct create route' do
          #expect(Vindicia::Repository::Base).to have_received(:post).with('/bases', hash_including({ body: mapped_request_to_json }))
        #end

        #it 'delgates request mapping correctly' do
          #expect(Vindicia::RequestMapper::Base).to have_received(:map).with(model)
        #end

        #it 'delegates response mapping correctly' do
          #expect(Vindicia::Response).to have_received(:new).with(data)
        #end

        #it 'returns the mapped response' do
          #expect(call_response).to eql(mapped_response)
        #end
      #end
    #end
  end
end
