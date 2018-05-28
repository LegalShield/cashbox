require 'spec_helper'

describe Cashbox::Rest::Cancel do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::Cancel
    property :vid
  end

  describe '#cancel' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end
end
