require 'spec_helper'

describe Vindicia::ResponseMapper::BillingPlan do
  describe '#map' do
    let(:mapper) { Vindicia::ResponseMapper::BillingPlan }
    let(:created) { double('created') }
    let(:periods) { double('periods') }
    let(:response) do
      {
        "object" => "BillingPlan",
        "id" => "1",
        "vid" => "4d9cee99a1301a0cd91e4921b228bfedf329257a",
        "created" => created,
        "description" => "daily",
        "status" => "Active",
        "periods" => periods,
        "billing_notification_days" => 1,
        "billing_descriptor" => "1"
      }
    end
    let(:instance) { mapper.new(response) }

    subject { instance.map }

    before do
      allow(DateTime).to receive(:parse).with(created).and_return(created)
      allow(Vindicia::ResponseMapper::Base).to receive(:map).with(periods).and_return(periods)
    end

    context 'attributes' do
      before do
        allow(Vindicia::Model::BillingPlan).to receive(:new)
        subject
      end

      it 'maps default billing plan correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(periods)
      end

      it 'maps default billing plan correctly' do
        expect(Vindicia::ResponseMapper::Base).to have_received(:map).with(periods)
      end

      it 'constructs the default billing plan model correctly' do
        expect(Vindicia::Model::BillingPlan).to have_received(:new).with({
          "id" => "1",
          "vid" => "4d9cee99a1301a0cd91e4921b228bfedf329257a",
          "created" => created,
          "description" => "daily",
          "status" => "Active",
          "periods" => periods,
          "billing_notification_days" => 1,
          "billing_descriptor" => "1"
        })
      end
    end

    context 'output' do
      it 'returns the correct instance type' do
        expect(subject).to be_a(Vindicia::Model::BillingPlan)
      end
    end
  end
end
