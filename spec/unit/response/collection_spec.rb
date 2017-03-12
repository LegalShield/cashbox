require 'spec_helper'

describe Vindicia::Response::Collection do
  subject { Vindicia::Response::Collection.new(nil) }

  it { should be_a(Vindicia::Response::Base) }
end

describe 'instance methods' do
  let(:http_response) do
    double('http_response', {
      to_h: {
        'object' => 'List',
        'data' => [ { 'object' => 'Base' } ],
        'total_count' => 3847
      }
    })
  end

  let(:request) { double('request', { perform: http_response }) }
  subject { Vindicia::Response::Collection.new(request) }

  context '#total_count' do
    it 'returns the total count from the response' do
      expect(subject.total_count).to eql(3847)
    end
  end

  it { is_expected.to delegate_method(:each).to(:body) }
  it { is_expected.to be_an(Enumerable) }
end
