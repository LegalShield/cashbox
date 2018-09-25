require 'spec_helper'

describe Cashbox::Rest::UpdatePayment do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::UpdatePayment
    property :vid
  end

  describe '#update_payment' do
    subject { self.class::TestModel.new({ vid: 'my-vid' }) }
    let(:request) { double('request', { response: 'my data' }) }
    let(:payment_method) { Cashbox::PaymentMethod.new }

    before do
      allow(subject.class).to receive(:cast)

      allow(Cashbox::Request).to receive(:new)
        .with(:post, '/test_models/my-vid?update_behavior=CatchUp&replace_on_all_subscriptions=0&ignore_avs=0&ignore_cvn=0', {
          body: {
            id: 'my-vid',
            payment_methods: {
              object: "List",
              data: [payment_method]
            }
          }.to_json
        })
        .and_return(request)

      subject.update_payment(payment_method)
    end

    it 'calls Cashbox::Request correctly' do
      expect(Cashbox::Request).to have_received(:new)
        .with(:post, '/test_models/my-vid?update_behavior=CatchUp&replace_on_all_subscriptions=0&ignore_avs=0&ignore_cvn=0', {
          body: {
            id: 'my-vid',
            payment_methods: {
              object: "List",
              data: [payment_method]
            }
          }.to_json
        })
    end

    it 'passes the response to cast correctly' do
      expect(subject.class).to have_received(:cast).with(subject, 'my data')
    end
  end
end
