require 'spec_helper'

describe 'Archive' do
  class self::Widget < Cashbox::Model
    include Cashbox::Rest::Archive

    property :vid
    property :id
    property :name
  end

  def api_response(body)
    { :status => 200, :body => body, :headers => headers }
  end

  let(:headers) { { 'Content-Type': 'application/json' } }

  describe '#archive' do
    subject { self.class::Widget.new({ vid: 'vid', id: 1, name: 'my-widget' }) }
    let(:body) { { 'object' => 'Widget', 'vid' => 1, 'id' => 1, 'name' => 'your-widget' }.to_json }
    let!(:stub) { stub_post('/widgets/vid').with({ body: { active: false }.to_json }).to_return(api_response(body)) }

    before { subject.archive }

    it 'makes the correct api call to archive' do
      expect(stub).to have_been_requested
    end
  end
end
