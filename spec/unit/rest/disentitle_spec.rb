require 'spec_helper'

describe Cashbox::Rest::Disentitle do
  class self::TestModel < Cashbox::Model
    include Cashbox::Rest::Disentitle
    property :vid
  end

  describe '#disentitle' do
    it 'calls Cashbox::Request correctly'
    it 'passes the response to cast correctly'
  end
end
