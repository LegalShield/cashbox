require "spec_helper"

describe Cashbox::Model do
  it { is_expected.to have_property(:message) }
  it { is_expected.to have_property(:type) }
  it { is_expected.to have_property(:code) }
  it { is_expected.to have_property(:url) }

  describe "#errors" do
    let(:model) { Cashbox::Model.new }

    before do
      model.message = 'Test message'
      model.type = 'test'
      model.code = 'TST'
      model.url = 'www.testing.legalshield'
    end

    it "returns the error messages with the type as the hash key" do
      expect(model.errors.messages.has_key?('test')).to eq(true)
    end

    it "returns the expected error message" do
      expect(model.errors.messages['test'][0]).to eq('Test message')
    end

    it "returns the expected error code" do
      expect(model.errors.messages['test'][1]).to eq('TST')
    end

    it "returns the expected error code" do
      expect(model.errors.messages['test'][2]).to eq('www.testing.legalshield')
    end

    it "does not populate the error messages if there is no message" do
      model.message = nil;

      expect(model.errors.messages.empty?).to eq(true)
    end
  end
end
