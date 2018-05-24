require 'spec_helper'

class TestDisentitleModel
  include Cashbox::Rest::Disentitle
end

describe TestDisentitleModel do
  context 'instance methods' do
    it 'has a archive' do
      expect(TestDisentitleModel.new).to respond_to(:disentitle)
    end
  end
end
