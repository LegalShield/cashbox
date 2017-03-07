require 'spec_helper'

describe 'Product' do
  before do
    Vindicia.test!
  end

  describe 'fetching products' do
    subject do
      Vindicia::Repository::Product.new.first
    end
    #binding.pry

    before do
      stub_get('/products')
        .with({ query: { limit: 1 } })
        .to_return(:status => 200, :body => fixture('products'), :headers => { 'Content-Type': 'application/json' })
    end

    it 'returns a product model' do
      expect(subject).to be_a(Vindicia::Model::Product)
    end
  end
end
