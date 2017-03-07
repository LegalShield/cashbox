require 'spec_helper'

describe Vindicia::RequestMapper::Base do
  let(:instance) { double('instance', { object: 'TestObject' } ) }

  context 'class methods' do
    describe '.map' do
      subject { Vindicia::RequestMapper::Base }

      let!(:fake_test_mapper) do
        module Vindicia::RequestMapper
          class TestObject < Base
          end
        end
        Vindicia::RequestMapper::TestObject
      end

      it 'returns a instance of a request mapper based on the passed in instance' do
        expect(subject.map(instance)).to be_a(Vindicia::RequestMapper::TestObject)
      end
    end

    describe '.initialize' do
      subject { Vindicia::RequestMapper::Base.new(instance) }

      it 'requires a instance argument' do
        expect(subject.instance_eval{ @instance }).to eql(instance)
      end
    end
  end

  context 'instance methods' do
    subject { Vindicia::RequestMapper::Base.new(instance) }

    describe '#to_json' do
      it 'returns the correct json' do
        expect(subject.to_json).to eql("{\"object\":\"TestObject\"}")
      end
    end

    describe '#object' do
      before { subject.object }

      it 'delegates object to the instance' do
        expect(instance).to have_received(:object)
      end
    end
  end
end
