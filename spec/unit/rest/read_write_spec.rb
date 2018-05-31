require 'spec_helper'

describe Cashbox::Rest::ReadWrite do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::ReadWrite

    property :id
    property :vid
    property :field
  end

  describe '.find' do
    subject { self.class::TestModel }
    let(:request) { double('request', { response: 'my-data' }) }
    let(:instance) { double('new instance') }

    before do
      allow(subject).to receive(:cast)
      allow(subject).to receive(:new).and_return(instance)
      allow(Cashbox::Request).to receive(:new).with(:get, '/test_models/my-vid').and_return(request)
    end

    context 'bad args' do
      it 'raises argument error when id is missing' do
        expect { subject.find }.to raise_error(ArgumentError)
      end
    end

    context 'with args' do
      before { subject.find('my-vid') }

      it 'calls Cashbox::Request correctly' do
        expect(Cashbox::Request).to have_received(:new).with(:get, '/test_models/my-vid')
      end

      it 'passes the response to cast correctly' do
        expect(subject).to have_received(:cast).with(instance, 'my-data')
      end
    end
  end

  describe '.first' do
    subject { self.class::TestModel }

    it 'calls where correctly' do
      allow(subject).to receive(:where).with({ limit: 1 }).and_return(['res'])
      expect(subject.first).to eql('res')
      expect(subject).to have_received(:where).with({ limit: 1 })
    end
  end

  describe '.all' do
    subject { self.class::TestModel }

    it 'calls where correctly' do
      allow(subject).to receive(:where).with(no_args).and_return([ ])
      subject.all
      expect(subject).to have_received(:where).with(no_args)
    end
  end

  describe '.where' do
    subject { self.class::TestModel }

    before do
      allow(subject).to receive(:query)
    end

    it 'calls query with the correct params' do
      subject.where({ field: 'value' })
      expect(subject).to have_received(:query).with({ field: 'value' }, nil)
    end

    it 'extracts a provided limit' do
      subject.where({ field: 'value', limit: 1 })
      expect(subject).to have_received(:query).with({ field: 'value' }, 1)
    end

    it 'symbolizes keys' do
      subject.where({ 'field' => 'value', 'limit' => 1 })
      expect(subject).to have_received(:query).with({ field: 'value' }, 1)
    end
  end

  describe '#save' do
    subject { self.class::TestModel.new }

    it 'calls save! correctly' do
      allow(subject).to receive(:save!).and_return(true)
      expect(subject.save).to eql(true)
      expect(subject).to have_received(:save!)
    end

    it 'returns false if save! throws an error' do
      allow(subject).to receive(:save!).and_raise('oh noes')
      expect(subject.save).to eql(false)
      expect(subject).to have_received(:save!)
    end
  end

  describe '#save!' do
    subject { self.class::TestModel.new({ field: 'value' }) }

    let(:request) { double('request', { response: {} }) }

    before do
      allow(subject.class).to receive(:cast)
      allow(Cashbox::Request).to receive(:new)
        .with(:post, '/test_models', { body: { field: 'value' }.to_json }).and_return(request)

      expect(subject.field).to eql('value')
      subject.save!
    end

    it 'calls Cashbox::Request correctly' do
      expect(Cashbox::Request).to have_received(:new)
        .with(:post, '/test_models', { body: { field: 'value' }.to_json })
    end

    it 'passes the response to cast correctly' do
      expect(subject.class).to have_received(:cast).with(subject, {})
    end
  end
end
