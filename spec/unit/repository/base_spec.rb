require 'spec_helper'

describe Vindicia::Repository::Base do
  context 'making calls' do

    let(:repository) { Vindicia::Repository::Base }

    before do
      Vindicia.username = 'u'
      Vindicia.password = 'p'
    end

    describe '#where' do
      context 'single fetch' do
        let(:collection) { double('collection') }

        let(:response) do
          Hashie::Mash.new({ 'total_count' => 200,
            'object' => 'List',
            'data' => 100.times.map { |n| { 'object' => 'Base', 'id' => n, 'vid' => n } },
            'next' => nil,
            'previous' => nil })
        end

        before do
          allow(Vindicia::Request)
            .to receive(:new)
            .with(:get, '/bases', { query: { limit: 100, name: 'Jon' } })
            .and_return(double('request', response: response))

          allow(Vindicia::Response::Collection)
            .to receive(:new)
            .with(array_including(kind_of(Vindicia::Model::Base)))
            .and_return(collection)
        end

        it 'creates a request instance' do
          repository.where({ name: 'Jon' })

          expect(Vindicia::Request)
            .to have_received(:new)
            .with(:get, '/bases', { query: { limit: 100, name: 'Jon' } })
        end

        it 'creates a response instance from the api response' do
          expect(repository.where({ name: 'Jon' })).to eq(collection)
        end

        it 'casts the response to vindicia models' do
          repository.where({ name: 'Jon' })

          expect(Vindicia::Response::Collection)
            .to have_received(:new)
            .with(array_including(kind_of(Vindicia::Model::Base)))
        end
      end

      context 'many fetches' do
        let(:response_one) do
          Hashie::Mash.new({ 'total_count' => 1000,
            'object' => 'List',
            'data' => 100.times.map { |n| { 'object' => 'Base', 'id' => n, 'vid' => n } },
            'next' => '/bases?starting_after=100&limit=100&name=Jon',
            'previous' => '/bases?ending_before=0&limit=100&name=Jon' })
        end

        let(:response_two) do
          Hashie::Mash.new({ 'total_count' => 1000,
            'object' => 'List',
            'data' => 100.times.map { |n| { 'object' => 'Base', 'id' => n, 'vid' => n } },
            'next' => '/bases?starting_after=200&limit=100&name=Jon',
            'previous' => '/bases?ending_before=100&limit=100&name=Jon' })
        end

        let(:response_three) do
          Hashie::Mash.new({ 'total_count' => 1000,
            'object' => 'List',
            'data' => [ ],
            'next' => nil,
            'previous' => nil })
        end

        before do
          allow(Vindicia::Request)
            .to receive(:new)
            .with(:get, '/bases', { query: { limit: 25, name: 'Jon' } })
            .and_return(double('request', response: response_one))

          allow(Vindicia::Request)
            .to receive(:new)
            .with(:get, '/bases', { query: { limit: 100, name: 'Jon' } })
            .and_return(double('request', response: response_one))

          allow(Vindicia::Request)
            .to receive(:new)
            .with(:get, '/bases', { query: { starting_after: '100', limit: 100, name: 'Jon' } })
            .and_return(double('request 2', response: response_two))

          allow(Vindicia::Request)
            .to receive(:new)
            .with(:get, '/bases', { query: { starting_after: '200', limit: 50, name: 'Jon' } })
            .and_return(double('request 3', response: response_three))
        end

        it 'can fetch more than 100 records' do
          repository.where({ name: 'Jon', limit: 250 })

          expect(Vindicia::Request)
            .to have_received(:new)
            .with(:get, '/bases', { query: { limit: 100, name: 'Jon' } }).ordered

          expect(Vindicia::Request)
            .to have_received(:new)
            .with(:get, '/bases', { query: { starting_after: '100', limit: 100, name: 'Jon' } }).ordered

          expect(Vindicia::Request)
            .to have_received(:new)
            .with(:get, '/bases', { query: { starting_after: '200', limit: 50, name: 'Jon' } }).ordered

          expect(Vindicia::Request).to have_received(:new).exactly(3).times
        end

        it 'can fetch less than 100 records' do
          repository.where({ name: 'Jon', limit: 25 })

          expect(Vindicia::Request)
            .to have_received(:new)
            .with(:get, '/bases', { query: { limit: 25, name: 'Jon' } })

          expect(Vindicia::Request).to have_received(:new).exactly(1).times
        end
      end
    end

    describe '#all' do
      it 'calls where' do
        allow(Vindicia::Repository::Base).to receive(:where).and_return([])
        repository.all
        expect(Vindicia::Repository::Base).to have_received(:where)
      end
    end

    describe '#first' do
      it 'calls where with limit 1' do
        allow(Vindicia::Repository::Base).to receive(:where).with({ limit: 1 }).and_return([])
        repository.first
        expect(Vindicia::Repository::Base).to have_received(:where).with({ limit: 1 })
      end
    end

    describe '#find' do
      let(:response) do
        { 'object' => 'Base',
          'id' => 1,
          'vid'=> 'v1' }
      end

      context 'success' do
        before do
          allow(Vindicia::Request).to receive(:new).with(:get, '/bases/1').and_return(double('request', response: response))
          allow(Vindicia::Response::Object).to receive(:new).with(kind_of(Vindicia::Model::Base))
          repository.find(1)
        end

        it 'makes the correct request' do
          expect(Vindicia::Request).to have_received(:new).with(:get, '/bases/1').once
        end

        it 'creates the correct response' do
          expect(Vindicia::Response::Object).to have_received(:new).with(kind_of(Vindicia::Model::Base))
        end
      end

      context 'failure' do
        it 'throws an error if an id is not supplied' do
          expect( -> { repository.find(nil) }).to raise_exception(ArgumentError)
        end
      end
    end
  end
end
