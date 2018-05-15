require 'spec_helper'

describe Cashbox::Repository do
  context 'making calls' do

    let(:model) { Cashbox::Model.new }
    let(:repository) { Cashbox::Repository.new(model) }

    context 'instance methods' do
      subject { repository }

      it { is_expected.to have_attr_reader(:instance) }
    end

    before do
      Cashbox.username = 'u'
      Cashbox.password = 'p'
    end

    describe '#where' do
      context 'single fetch' do
        let(:response) do
          Hashie::Mash.new({
            'total_count' => 200,
            'object' => 'List',
            'data' => 100.times.map { Hash.new },
            'next' => nil,
            'previous' => nil
          })
        end

        before do
          allow(Cashbox::Request)
            .to receive(:new)
            .with(:get, '/models', { query: { limit: 100, name: 'Jon' } })
            .and_return(double('request', response: response))
        end

        it 'creates a request instance' do
          repository.where({ name: 'Jon' })

          expect(Cashbox::Request)
            .to have_received(:new)
            .with(:get, '/models', { query: { limit: 100, name: 'Jon' } })
        end

        it 'casts the response to vindicia models' do
          objects = repository.where({ name: 'Jon' })
          expect(objects).to be_an(Array)
          expect(objects.map(&:class).uniq.count).to eql(1)
          expect(objects.first).to eq(model)
        end
      end

      context 'many fetches' do
        let(:response_one) do
          Hashie::Mash.new({
            'total_count' => 1000,
            'object' => 'List',
            'data' => 100.times.map { Hash.new },
            'next' => '/models?starting_after=100&limit=100&name=Jon',
            'previous' => '/models?ending_before=0&limit=100&name=Jon'
          })
        end

        let(:response_two) do
          Hashie::Mash.new({
            'total_count' => 1000,
            'object' => 'List',
            'data' => 100.times.map { Hash.new },
            'next' => '/models?starting_after=200&limit=100&name=Jon',
            'previous' => '/models?ending_before=100&limit=100&name=Jon'
          })
        end

        let(:response_three) do
          Hashie::Mash.new({
            'total_count' => 1000,
            'object' => 'List',
            'data' => [ ],
            'next' => nil,
            'previous' => nil
          })
        end

        before do
          allow(Cashbox::Request)
            .to receive(:new)
            .with(:get, '/models', { query: { limit: 25, name: 'Jon' } })
            .and_return(double('request', response: response_one))

          allow(Cashbox::Request)
            .to receive(:new)
            .with(:get, '/models', { query: { limit: 100, name: 'Jon' } })
            .and_return(double('request', response: response_one))

          allow(Cashbox::Request)
            .to receive(:new)
            .with(:get, '/models', { query: { starting_after: '100', limit: 100, name: 'Jon' } })
            .and_return(double('request 2', response: response_two))

          allow(Cashbox::Request)
            .to receive(:new)
            .with(:get, '/models', { query: { starting_after: '200', limit: 50, name: 'Jon' } })
            .and_return(double('request 3', response: response_three))
        end

        it 'can fetch more than 100 records' do
          repository.where({ name: 'Jon', limit: 250 })

          expect(Cashbox::Request)
            .to have_received(:new)
            .with(:get, '/models', { query: { limit: 100, name: 'Jon' } }).ordered

          expect(Cashbox::Request)
            .to have_received(:new)
            .with(:get, '/models', { query: { starting_after: '100', limit: 100, name: 'Jon' } }).ordered

          expect(Cashbox::Request)
            .to have_received(:new)
            .with(:get, '/models', { query: { starting_after: '200', limit: 50, name: 'Jon' } }).ordered

          expect(Cashbox::Request).to have_received(:new).exactly(3).times
        end

        it 'can fetch less than 100 records' do
          repository.where({ name: 'Jon', limit: 25 })

          expect(Cashbox::Request)
            .to have_received(:new)
            .with(:get, '/models', { query: { limit: 25, name: 'Jon' } })

          expect(Cashbox::Request).to have_received(:new).exactly(1).times
        end
      end
    end

    describe '#all' do
      it 'calls where' do
        allow(repository).to receive(:where).and_return([])
        repository.all
        expect(repository).to have_received(:where)
      end
    end

    describe '#first' do
      it 'calls where with limit 1' do
        allow(repository).to receive(:where).with({ limit: 1 }).and_return([])
        repository.first
        expect(repository).to have_received(:where).with({ limit: 1 })
      end
    end

    describe '#find' do
      let(:response) { Hash.new }

      let(:result) { repository.find(1) }

      context 'success' do
        before do
          allow(Cashbox::Request).to receive(:new).with(:get, '/models/1').and_return(double('request', response: response))
          repository.find(1)
        end

        it 'makes the correct request' do
          expect(Cashbox::Request).to have_received(:new).with(:get, '/models/1').once
        end

        it 'makes the correct request' do
          expect(result).to be_a(Cashbox::Model)
          expect(result).to eq(model)
          expect(result.object_id).to eq(model.object_id)
        end
      end

      context 'failure' do
        it 'throws an error if an id is not supplied' do
          expect( -> { repository.find(nil) }).to raise_exception(ArgumentError)
        end
      end
    end

    describe '#save' do
      let(:model) { Cashbox::Account.new({ vid: 'vid-1', id: 1 }) }
      let(:repository) { Cashbox::Repository.new(model) }
      let(:result) { repository.save }
      let(:response) { Hash.new }

      context 'success' do
        before do
          allow(Cashbox::Request)
            .to receive(:new)
            .with(:post, '/accounts/vid-1', { body: model.to_json })
            .and_return(double('request', response: response))
        end

        it 'makes the correct request' do
          repository.save
          expect(Cashbox::Request).to have_received(:new).with(:post, '/accounts/vid-1', { body: model.to_json }).once
        end

        it 'parses the response correctly' do
          expect(result).to be_a(Cashbox::Account)
          expect(result).to eq(model)
          expect(result.object_id).to eq(model.object_id)
        end
      end

      context 'failure' do
        before do
          allow(Cashbox::Request)
            .to receive(:new)
            .with(:post, '/accounts/vid-1', { body: model.to_json })
            .and_return(double('request', response: { 'message' => 'Danger', 'object' => 'Error' }))
        end

        it 'raises an error' do
          expect { repository.save }.to raise_error(Cashbox::Error, "Danger")
        end
      end
    end

    describe "#destroy" do
      let(:model) { Cashbox::Subscription.new({ vid: 'vid-1', id: 1 }) }
      let(:repository) { Cashbox::Repository.new(model) }
      let(:result) { repository.destroy }
      let(:response) { Hash.new }

      context "failure" do
        before do
          allow(Cashbox::Request)
            .to receive(:new)
            .with(:post, '/subscriptions/vid-1/actions/cancel')
            .and_return(double('request', response: { 'message' => 'Danger', 'object' => 'Error' }))
        end

        it 'raises an error' do
          expect { repository.destroy }.to raise_error(Cashbox::Error, "Danger")
        end
      end

      context "success" do
        before do
          allow(Cashbox::Request)
            .to receive(:new)
            .with(:post, '/subscriptions/vid-1/actions/cancel')
            .and_return(double('request', response: response ))
        end

        it 'makes the correct request' do
          repository.destroy
          expect(Cashbox::Request).to have_received(:new).with(:post, '/subscriptions/vid-1/actions/cancel').once
        end
      end
    end
  end
end
