require 'spec_helper'

class TestSaveModel
  include Cashbox::Rest::Save
end

describe TestSaveModel do
  context 'instance methods' do
    it 'has a save' do
      expect(TestSaveModel.new).to respond_to(:save)
    end

    it 'has a save!' do
      expect(TestSaveModel.new).to respond_to(:save!)
    end
  end
end
