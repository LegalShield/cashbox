require 'spec_helper'

describe 'Refund' do
  class self::Widget < Cashbox::Model
    include Cashbox::Rest::Refund

    property :vid
    property :amt
  end

  def api_response(body)
    { :status => 200, :body => body, :headers => headers }
  end

  let(:headers) { { 'Content-Type': 'application/json' } }

  describe '#refund' do
    subject { self.class::Widget.new({ vid: 'vid', amt: '14' }) }
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'amt' => '14' }.to_json }
    let!(:stub) { stub_post('/widgets/vid/refunds').to_return(api_response(body)) }

    before { subject.refund }

    it 'makes the correct api call to refund' do
      expect(stub).to have_been_requested
    end
  end
end
