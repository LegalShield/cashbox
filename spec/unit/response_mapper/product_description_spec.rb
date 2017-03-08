require 'spec_helper'

describe Vindicia::ResponseMapper::ProductDescription do
  describe '#map' do
    let(:mapper) { Vindicia::ResponseMapper::ProductDescription }
    let(:response) do
      {
        "object" => "ProductDescription",
        "language" => "EN",
        "description" => "Oklahoma Limited Personal Plan"
      }
    end
    let(:instance) { mapper.new(response) }

    subject { instance.map }

    context 'attributes' do
      before do
        allow(Vindicia::Model::ProductDescription).to receive(:new)
        subject
      end

      it 'maps default billing plan correctly' do
        expect(Vindicia::Model::ProductDescription).to have_received(:new).with({
          'language' => 'EN',
          'description' => 'Oklahoma Limited Personal Plan'
        })
      end
    end

    context 'output' do
      it 'returns the correct instance type' do
        expect(subject).to be_a(Vindicia::Model::ProductDescription)
      end
    end
  end
end

