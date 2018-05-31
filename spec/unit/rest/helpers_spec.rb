require 'spec_helper'

describe Cashbox::Rest::Helpers do
  class self::Helper < Cashbox::Model
    include Cashbox::Rest::Helpers
  end

  context 'class methods' do
    subject { self.class::Helper }

    describe 'route' do
      it 'without arguments' do
        expect(subject.route).to eql('/helpers')
      end

      it 'with arguments' do
        expect(subject.route(1)).to eql('/helpers/1')
      end
    end

    describe 'query' do
      it 'is tested'
    end

    describe '.query' do
      subject { self.class::Helper }
      let(:instance) { double('new instance') }

      #before do
        #allow(subject).to receive(:cast).and_return([])
        #allow(subject).to receive(:new).and_return(instance)
      #end

      #context 'with no limit' do
        #let(:response_two) { double('response_one', { next: nil }) }
        #let(:request_two) { double('request', { response: response_two }) }

        #let(:response_one) { double('response_two', { next: 'test_models?page=2&field=value' }) }
        #let(:request_one) { double('request', { response: response_one }) }

        #before do
          #allow(Cashbox::Request).to receive(:new).with(:get, '/test_models', { query: { 'field' => 'value', 'limit' => 100 } }).and_return(request_one)
          #allow(Cashbox::Request).to receive(:new).with(:get, '/test_models', { query: { 'page' => '2', 'field' => 'value', 'limit' => 100 } }).and_return(request_two)

          #subject.where({ field: 'value' })
        #end

        #it 'calls Cashbox::Request correctly' do
          #expect(Cashbox::Request).to have_received(:new).with(:get, '/test_models', { query: { field: 'value', limit: 100 } }).ordered
          #expect(Cashbox::Request).to have_received(:new).with(:get, '/test_models', { query: { 'field' => 'value', 'limit' => 100, 'page' => '2' } }).ordered
        #end

        #it 'passes the response to cast correctly' do
          #expect(subject).to have_received(:cast).with(instance, response_one).ordered
          #expect(subject).to have_received(:cast).with(instance, response_two).ordered
        #end
      #end

      #context 'limit 10' do
        #let(:response) { double('response_one', { next: nil }) }
        #let(:request) { double('request', { response: response }) }

        #before do
          #allow(Cashbox::Request).to receive(:new)
            #.with(:get, '/test_models', { query: { 'field' => 'value', 'limit' => 10 } })
            #.and_return(request)

          #subject.where({ field: 'value', limit: 10 })
        #end

        #it 'calls Cashbox::Request correctly' do
          #expect(Cashbox::Request).to have_received(:new)
            #.with(:get, '/test_models', { query: { field: 'value', limit: 10 } })
        #end

        #it 'passes the response to cast correctly' do
          #expect(subject).to have_received(:cast).with(instance, response)
        #end
      #end
    end

    describe 'cast' do
      it 'is tested'
    end

  end

  context 'instance methods' do
    subject { self.class::Helper.new }

    before do
      allow(subject.class).to receive(:route)
    end

    describe 'route' do
      it 'delegates to the class method without args' do
        subject.route
        expect(subject.class).to have_received(:route)
      end

      it 'delegates to the class method without args' do
        subject.route(1)
        expect(subject.class).to have_received(:route).with(1)
      end
    end
  end

end
