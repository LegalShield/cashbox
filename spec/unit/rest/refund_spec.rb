require 'spec_helper'

describe Cashbox::Rest::Refund do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::Refund
    property :vid
  end

  describe '#refund' do
    subject { self.class::TestModel.new({ vid: 'my-vid' }) }
    let(:request) { double('request', { response: 'my data' }) }

    before do
      allow(subject.class).to receive(:cast)

      allow(Cashbox::Request).to receive(:new)
        .with(:post, '/test_models/my-vid/refunds')
        .and_return(request)

      subject.refund
    end

    it 'calls Cashbox::Request correctly' do
      expect(Cashbox::Request).to have_received(:new).with(:post, '/test_models/my-vid/refunds')
    end

    it 'passes the response to cast correctly' do
      expect(subject.class).to have_received(:cast).with(Cashbox::Refund.new, 'my data')
    end
  end
end
