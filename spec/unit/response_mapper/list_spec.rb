require 'spec_helper'

describe Vindicia::ResponseMapper::List do
  describe '#map' do
    let(:mapper)        { Vindicia::ResponseMapper::List }
    let(:response)      { { 'data' => [ first_record, second_record ] } }
    let(:first_record)  { double('first record') }
    let(:second_record) { double('second record') }

    before do
      allow(mapper).to receive(:map).with(first_record)
      allow(mapper).to receive(:map).with(second_record)
      mapper.new(response).map
    end

    it 'returns the correct instance type' do
      expect(mapper).to have_received(:map).with(first_record).ordered
      expect(mapper).to have_received(:map).with(second_record).ordered
    end
  end
end

