require 'spec_helper'

class TestReadWriteModel
  include Cashbox::Rest::ReadWrite
end

describe TestReadWriteModel do
  context 'class methods' do
    it 'has a find' do
      expect(TestReadWriteModel).to respond_to(:find)
    end

    it 'has a first' do
      expect(TestReadWriteModel).to respond_to(:first)
    end

    it 'has an all' do
      expect(TestReadWriteModel).to respond_to(:all)
    end

    it 'has a where' do
      expect(TestReadWriteModel).to respond_to(:where)
    end
  end

  context 'instance methods' do
    it 'has a save' do
      expect(TestReadWriteModel.new).to respond_to(:save)
    end

    it 'has a save!' do
      expect(TestReadWriteModel.new).to respond_to(:save!)
    end
  end
end
