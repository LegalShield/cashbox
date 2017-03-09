require 'spec_helper'

describe 'Product' do
  before do
    Vindicia.test!
  end

  describe 'fetching products' do
    subject do
      Vindicia::Repository::Product.first
    end

    before do
      stub_get('/products')
        .with({ query: { limit: 1 } })
        .to_return(:status => 200, :body => fixture('product'), :headers => { 'Content-Type': 'application/json' })
    end

    it 'returns a product model' do
      expect(subject).to be_an_instance_of(Vindicia::Model::Product)
    end

    it 'has the right id' do
      expect(subject.vid).to eql('7118699d6406494d7672503761fa21809fefaf25')
    end
  end

  describe 'fetching products' do
    subject do
      Vindicia::Repository::Product.first
    end

    before do
      stub_get('/products')
        .with({ query: { limit: 1 } })
        .to_return(:status => 200, :body => fixture('product'), :headers => { 'Content-Type': 'application/json' })
    end

    it 'returns a product model' do
      expect(subject).to be_an_instance_of(Vindicia::Model::Product)
    end

    it 'has the right id' do
      expect(subject.vid).to eql('7118699d6406494d7672503761fa21809fefaf25')
    end
  end
end
