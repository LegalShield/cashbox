require 'spec_helper'

describe Cashbox::Rest::ReadWrite do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::ReadWrite
    property :vid
  end

  describe '.find' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end

  describe '.first' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end

  describe '.all' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end

  describe '.where' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end

  describe '#save' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end

  describe '#save!' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end
end
