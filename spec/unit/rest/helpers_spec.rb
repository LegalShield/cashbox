require 'spec_helper'

describe Cashbox::Rest::Helpers do
  class self::TestArchiveModel < Cashbox::Model
    include Cashbox::Rest::Helpers
  end

  context 'class methods' do
    subject { self.class::TestArchiveModel }

    describe 'route' do
      it 'without arguments' do
        expect(subject.route).to eql('/test_archive_models')
      end

      it 'with arguments' do
        expect(subject.route(1)).to eql('/test_archive_models/1')
      end
    end

    describe 'query' do
      it 'is tested'
    end

    describe 'cast' do
      it 'is tested'
    end

  end

  context 'instance methods' do
    subject { self.class::TestArchiveModel.new }

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
