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
  end

  context 'instance methods' do
    describe 'route' do
      subject { self.class::Helper.new }

      before do
        allow(subject.class).to receive(:route)
      end

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
