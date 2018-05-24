require 'spec_helper'

class TestCancelModel
  include Cashbox::Rest::Cancel
end

describe TestCancelModel do
  context 'instance methods' do
    it 'has a cancel' do
      expect(TestCancelModel.new).to respond_to(:cancel)
    end
  end
end
