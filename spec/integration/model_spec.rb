require 'spec_helper'

class TestModel < Vindicia::Model
  include Vindicia::Concern::Objectable
  include Vindicia::Concern::Persistable

  property :id
end

describe 'Model' do
  before { Vindicia.test! }
  after { Vindicia.production! }

  describe 'first' do
    subject { TestModel.first }

    before do
      stub_get('/test_models')
        .with({ query: { limit: 1 } })
        .to_return({
          :status => 200,
          :body => {
            object: 'List',
            data: [ { id: '1' } ],
            total_count: 1,
            url: '/test_models?limit=1',
            next: '/test_models?limit=1&starting_after=1',
            previous: '/test_models?limit=1&ending_before=2'
          }.to_json,
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it { is_expected.to be_a(TestModel) }
    its(:id) { is_expected.to eql('1') }
  end

  describe 'complex query' do
    subject do
      TestModel.where({ property: 'value' }).limit(3).to_a
    end

    before do
      stub_get('/test_models')
        .with({ query: { limit: 3, property: 'value' } })
        .to_return({
          :status => 200,
          :body => {
            object: 'List',
            data: [ { id: '1' }, { id: '2' }, { id: '3' } ],
            total_count: 3,
            url: '/test_models?limit=3&property=value',
            next: '/test_models?limit=3&starting_after=3&property=value',
            previous: '/test_models?limit=3&ending_before=1&property=value'
          }.to_json,
          :headers => { 'Content-Type': 'application/json' }
        })

      stub_get('/test_models')
        .with({ query: { limit: 3, property: 'value', starting_after: 3 } })
        .to_return({
          :status => 200,
          :body => {
            object: 'List',
            data: [ ],
            total_count: 3,
            url: '/test_models?limit=3&starting_after=3&property=value'
          }.to_json,
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it { is_expected.to be_an(Array) }
    its(:first) { is_expected.to be_a(TestModel) }
  end
end
