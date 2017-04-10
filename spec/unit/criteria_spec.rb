require 'spec_helper'

describe Vindicia::Criteria do
  let(:model) { Vindicia::Model.new }
  let(:repository) { Vindicia::Repository.new(model) }

  #context 'init' do
    #let(:criteria) { Vindicia::Criteria.new(repository) }

    #it 'inits with a model repository' do
      #expect(criteria.repository).to eql(repository)
    #end
  #end

  context '#where' do
    subject { Vindicia::Criteria.new(repository) }

    it 'returns the criteria' do
      expect(subject.where).to eql(subject)
    end

    it 'adds the where clause to the query' do
      query = subject.where({ name: 'jon' }).to_query

      expect(query).to eql({ name: 'jon', limit: 100 })
    end
  end

  context '#limit' do
    subject { Vindicia::Criteria.new(repository) }

    it 'returns the criteria' do
      expect(subject.limit).to eql(subject)
    end

    it 'adds the where clause to the query' do
      query = subject.limit(10).to_query

      expect(query).to eql({ limit: 10 })
    end
  end

  #context '#first' do
    #subject { Vindicia::Criteria.new(repository) }

    #it 'returns the criteria' do
      #expect(subject.first).to eql(subject)
    #end
  #end
end
