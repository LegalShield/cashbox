require 'spec_helper'

describe Vindicia::Concern::Persistable do
  let!(:klass) do
    class PersistableTestClass
      include Vindicia::Concern::Persistable
    end
    PersistableTestClass
  end

  context '.repository' do
    subject { klass.repository }

    it 'returns an instance of a repository' do
      expect(subject).to be_a(Vindicia::Repository)
    end

    it 'inits with the repository with an instance of the model' do
      allow(Vindicia::Repository).to receive(:new).with(kind_of(PersistableTestClass))
      subject
      expect(Vindicia::Repository).to have_received(:new).with(kind_of(PersistableTestClass))
    end
  end

  context '#repository' do
    let(:instance) { klass.new }
    subject { instance.repository }

    it 'returns an instance of a repository' do
      expect(subject).to be_a(Vindicia::Repository)
    end

    it 'inits with the repository with an instance of the model' do
      allow(Vindicia::Repository).to receive(:new).with(kind_of(PersistableTestClass))
      subject
      expect(Vindicia::Repository).to have_received(:new).with(kind_of(PersistableTestClass))
    end

    it 'memoizes the repository' do
      allow(Vindicia::Repository).to receive(:new).with(kind_of(PersistableTestClass)).and_return(double('repository'))
      instance.repository
      instance.repository
      expect(Vindicia::Repository).to have_received(:new).with(kind_of(PersistableTestClass)).once
    end

  end

  context 'forwardable' do
    subject { klass }

    it { is_expected.to be_kind_of(SingleForwardable) }
    it { is_expected.to be_kind_of(Forwardable) }

    context 'class methods' do
      subject { klass }

      it { is_expected.to delegate_method(:all).to(:repository) }
      it { is_expected.to delegate_method(:where).to(:repository) }
      it { is_expected.to delegate_method(:first).to(:repository) }
    end

    context 'instance methods' do
      subject { klass.new }

      it { is_expected.to delegate_method(:save).to(:repository) }
    end
  end
end
