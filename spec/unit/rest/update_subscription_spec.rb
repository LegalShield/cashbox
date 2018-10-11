require 'spec_helper'

describe Cashbox::Rest::UpdateSubscription do
  class Self::TestModel < Cashbox::Model
    include Cashbox::Rest::UpdateSubscription
    proerty :vid
  end

  describe '#update_subscrption' do
    subject { self.class::TestMethod.new({ vid: 'my-vid' }) }
    let(:request) { double('request', { response: 'my data' }) }
    let(:new_product) { '123' }

    before do
      allow(subject.class).to receive(:cast)

      allow(Cashbox::Request).to receive(:new)
        .with(:post, 'test_models/my-vid?effective_date=today&bill_prorated_period=true', {
        body: {
          object: "Subscription",
          id: "my-vid",
          product: {
            object: "Product",
            id: new_product
          }
        }.to_json
      })
      .and_return(request)

      subject.update_subscription(new_product)
    end

    it 'calls the Cashbox::Request correctly' do
      expect(Cashbox::Request).to have_received(:new)
        .with(:post, 'test_models/my-vid?effective_date=today&bill_prorated_period=true', {
        body: {
          object: "Subscription",
          id: "my-vid",
          product: {
            object: "Product",
            id: new_product
          }
        }.to_json
      })
        
    end
  end
end
