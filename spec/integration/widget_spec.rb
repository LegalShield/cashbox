require 'spec_helper'

describe 'Widget' do
  class self::Widget < Cashbox::Model
    include Cashbox::Rest::Archive
    property :vid
  end

  subject do
    self.class::Widget.new({ vid: 1 })
  end

  before { Cashbox.test! }
  after { Cashbox.production! }

  describe 'archive a widget' do
    let!(:stub) do
      stub_post('/widgets/1')
        .with({ body: { active: false }.to_json })
        .to_return({
          :status => 200,
          :body => { 'object' => 'Widget', 'vid' => 1, 'id' => 2 }.to_json,
          :headers => { 'Content-Type': 'application/json' }
        })
    end

    it 'makes the correct call to create' do
      subject.archive
      expect(stub).to have_been_requested
    end
  end
end
