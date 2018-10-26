require 'spec_helper'

describe 'Disentitle' do
  class self::Widget < Cashbox::Model
    include Cashbox::Rest::Disentitle

    property :vid
    property :id
    property :name
  end

  def api_response(body)
    { :status => 200, :body => body, :headers => headers }
  end

  let(:headers) { { 'Content-Type': 'application/json' } }

  describe '#disentitle' do
    subject { self.class::Widget.new({ vid: 'vid', id: 1, name: 'my-widget' }) }
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'your-widget' }.to_json }
    let!(:stub) { stub_post('/widgets/vid/actions/cancel?disentitle=true').to_return(api_response(body)) }

    before { subject.disentitle }

    it 'makes the correct api call to disentitle' do
      expect(stub).to have_been_requested
    end
  end
end
