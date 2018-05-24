require 'spec_helper'

class TestFindModel
  include Cashbox::Rest::Find
end

describe TestFindModel do
  context 'class methods' do
    it 'has a find' do
      expect(TestFindModel).to respond_to(:find)
    end

    it 'has a first' do
      expect(TestFindModel).to respond_to(:first)
    end

    it 'has an all' do
      expect(TestFindModel).to respond_to(:all)
    end

    it 'has a where' do
      expect(TestFindModel).to respond_to(:where)
    end
  end
end
