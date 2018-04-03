require 'spec_helper'

describe Cashbox::Criteria do
  let(:model) { Cashbox::Model.new }
  let(:repository) { Cashbox::Repository.new(model) }

  context '#where' do
    subject { Cashbox::Criteria.new(repository) }

    it 'returns the criteria' do
      expect(subject.where).to eql(subject)
    end

    it 'adds criteria to the query' do
      query = subject.where({ name: 'jon' }).explain

      expect(query).to eql({ name: 'jon' })
    end
  end

  context '#limit' do
    subject { Cashbox::Criteria.new(repository) }

    it 'returns the criteria' do
      expect(subject.limit).to eql(subject)
    end

    it 'adds limit to the query' do
      query = subject.limit(10).explain

      expect(query).to eql({ limit: 10 })
    end
  end

  #context '#first' do
    #subject { Cashbox::Criteria.new(repository) }

    #it 'returns the criteria' do
      #expect(subject.first).to eql(subject)
    #end
  #end
end
