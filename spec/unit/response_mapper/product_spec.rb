require 'spec_helper'

describe Vindicia::ResponseMapper::Product do
  describe '#map' do
    let(:mapper)               { Vindicia::ResponseMapper::Product }
    let(:created)              { double('created') }
    let(:default_billing_plan) { double('default_billing_plan') }
    let(:entitlements)         { double('entitlements') }
    let(:prices)               { double('prices') }
    let(:descriptions)         { double('descriptions') }
    let(:response) do
      {
        "object" => "Product",
        "id" => "1",
        "vid" => "7118699d6406494d7672503761fa21809fefaf25",
        "created" => created,
        "descriptions" => descriptions,
        "status" => "Active",
        "default_billing_plan" => default_billing_plan,
        "entitlements" => entitlements,
        "billing_descriptor" => "1",
        "credit_granted" => {
          "object" => "Credit"
        },
        "prices" => prices,
      }
    end
    let(:instance) { mapper.new(response) }

    subject { instance.map }

    before do
      allow(DateTime).to receive(:parse).with(created).and_return(created)
      allow(Vindicia::ResponseMapper::Base).to receive(:map).with(default_billing_plan).and_return(default_billing_plan)
      allow(Vindicia::ResponseMapper::Base).to receive(:map).with(entitlements).and_return(entitlements)
      allow(Vindicia::ResponseMapper::Base).to receive(:map).with(prices).and_return(prices)
      allow(Vindicia::ResponseMapper::Base).to receive(:map).with(descriptions).and_return(descriptions)
    end

    context 'attributes' do
      before { subject }

      it 'maps default billing plan correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(default_billing_plan)
      end

      it 'maps entitlements correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(entitlements)
      end

      it 'maps prices correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(prices)
      end

      it 'maps descriptions correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(descriptions)
      end

      it 'maps created correctly' do
        expect(DateTime).to have_received(:parse).with(created)
      end

      it '' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(descriptions)
      end
    end

    context 'output' do
      it 'returns the correct instance type' do
        expect(subject).to be_a(Vindicia::Model::Product)
      end
    end
  end
end
