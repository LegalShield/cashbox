require 'spec_helper'

describe Cashbox::Rest::Archive do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::Archive
    property :vid
  end

  describe '#archive' do
    subject { self.class::TestModel.new({ vid: 'my-vid' }) }
    let(:request) { double('request', { response: 'my data' }) }

    before do
      allow(subject).to receive(:cast)

      allow(Cashbox::Request).to receive(:new)
        .with(:post, '/test_models/my-vid', { active: false })
        .and_return(request)
    end

    it 'calls Cashbox::Request correctly' do
      subject.archive

      expect(Cashbox::Request).to have_received(:new).with(:post, '/test_models/my-vid', { active: false })
      expect(subject).to have_received(:cast).with(subject, 'my data')
    end

    it 'passes the response to cast correctly'
  end
end
