require 'spec_helper'

class TestArchiveModel
  include Cashbox::Rest::Archive
end

describe TestArchiveModel do
  context 'instance methods' do
    it 'has a archive' do
      expect(TestArchiveModel.new).to respond_to(:archive)
    end
  end
end
