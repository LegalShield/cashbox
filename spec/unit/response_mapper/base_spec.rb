require 'spec_helper'

describe Vindicia::ResponseMapper::Base do
  describe '.map' do
    let!(:test_response_mapper) do
      module Vindicia::ResponseMapper
        class Test < Base
        end
      end

      Vindicia::ResponseMapper::Test
    end

    let(:test_model) do
      module Vindicia::Model
        class Test < Base
        end
      end

      Vindicia::Model::Test
    end

    let(:response) { { 'id' => 1, 'object' => 'Test' } }
    let(:model)    { test_model.new }
    let(:mapper)   { Vindicia::ResponseMapper::Base }

    subject { mapper.map(response) }

    before do
      allow_any_instance_of(Vindicia::ResponseMapper::Test).to receive(:map).and_return(model)
    end

    it 'returns the correct instance type' do
      expect(subject).to be_a(Vindicia::Model::Test)
    end
  end
end
