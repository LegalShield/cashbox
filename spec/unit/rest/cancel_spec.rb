require 'spec_helper'

describe Cashbox::Rest::Cancel do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::Cancel
    property :vid
  end

  describe '#cancel' do
    subject { self.class::TestModel.new({ vid: 'my-vid' }) }
    let(:request) { double('request', { response: 'my data' }) }

    before do
      allow(subject.class).to receive(:cast)

      allow(Cashbox::Request).to receive(:new)
        .with(:post, '/test_models/my-vid/actions/cancel')
        .and_return(request)

      subject.cancel
    end

    it 'calls Cashbox::Request correctly' do
      expect(Cashbox::Request).to have_received(:new).with(:post, '/test_models/my-vid/actions/cancel')
    end

    it 'passes the response to cast correctly' do
      expect(subject.class).to have_received(:cast).with(subject, 'my data')
    end
  end
end
