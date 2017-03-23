require 'spec_helper'

describe Vindicia::Concern::Persistable do
  let!(:klass) do
    class PersistableTestClass
      include Vindicia::Concern::Persistable
    end
    PersistableTestClass
  end

  context '.all' do
    subject { klass }

    let(:repository) { double('repostiry', all: nil) }

    before do
      allow(Vindicia::Repository)
        .to receive(:new)
        .with(kind_of(PersistableTestClass))
        .and_return(repository)

      allow(repository).to receive(:all)

      subject.all
    end

    it 'inits a new repository' do
      expect(Vindicia::Repository).to have_received(:new).with(kind_of(PersistableTestClass))
    end

    it 'calls all on the repository instance' do
      expect(repository).to have_received(:all)
    end
  end

  context '.where' do
    subject { klass }

    let(:repository) { double('repostiry', where: nil) }

    before do
      allow(Vindicia::Repository)
        .to receive(:new)
        .with(kind_of(PersistableTestClass))
        .and_return(repository)

      allow(repository).to receive(:where).with(any_args)

      subject.where({ name: 'Jon' })
    end

    it 'inits a new repository' do
      expect(Vindicia::Repository).to have_received(:new).with(kind_of(PersistableTestClass))
    end

    it 'calls all on the repository instance' do
      expect(repository).to have_received(:where)
    end

    it 'passes through args' do
      expect(repository).to have_received(:where).with({ name: 'Jon' })
    end
  end

  context '.first' do
    subject { klass }

    let(:repository) { double('repostiry', first: nil) }

    before do
      allow(Vindicia::Repository)
        .to receive(:new)
        .with(kind_of(PersistableTestClass))
        .and_return(repository)

      allow(repository).to receive(:first)

      subject.first
    end

    it 'inits a new repository' do
      expect(Vindicia::Repository).to have_received(:new).with(kind_of(PersistableTestClass))
    end

    it 'calls all on the repository instance' do
      expect(repository).to have_received(:first)
    end
  end

  context '#save' do
    subject { klass.new }

    let(:repository) { double('repostiry', save: nil) }

    before do
      allow(Vindicia::Repository)
        .to receive(:new)
        .with(kind_of(PersistableTestClass))
        .and_return(repository)

      allow(repository).to receive(:save)

      subject.save
    end

    it 'inits a new repository' do
      expect(Vindicia::Repository).to have_received(:new).with(kind_of(PersistableTestClass))
    end

    it 'calls all on the repository instance' do
      expect(repository).to have_received(:save)
    end
  end
end
