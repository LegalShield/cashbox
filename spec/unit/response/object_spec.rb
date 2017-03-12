require 'spec_helper'

describe Vindicia::Response::Object do
  subject { Vindicia::Response::Object.new(nil) }

  it { is_expected.to be_a(Vindicia::Response::Base) }
end

describe 'instance methods' do
  let(:base) {  }
  let(:request) { double('request', { perform: http_response }) }
  subject { Vindicia::Response::Object.new(request) }

  context '#raw_body' do
    let(:http_response) { double('http_response', { to_h: { 'object' => 'Base' } }) }

    it 'turns the raw hash of the response' do
      expect(subject.raw_body).to eql({ 'object' => 'Base' })
    end

    it 'caches the request' do
      subject.body
      subject.body
      expect(request).to have_received(:perform).once
    end
  end

  context '#body' do
    context 'error' do
      let(:http_response) { double('http_response', { to_h: { 'object' => 'Error' } }) }

      it 'returns an exception on error' do
        expect(subject.body).to be_a(Vindicia::Exception)
      end
    end

    context 'list' do
      let(:http_response) do
        double('http_response', {
          to_h: {
            'object' => 'List',
            'data' => [ { 'object' => 'Base' }, { 'object' => 'Base' } ]
          }
        })
      end

      it 'casts to an array' do
        expect(subject.body).to be_an(Array)
      end

      it 'casts each record inside' do
        subject.body.each do |model|
          expect(model).to be_a(Vindicia::Model::Base)
        end
      end

      it 'caches the body' do
        allow(subject).to receive(:cast).and_return('')
        subject.body
        subject.body
        expect(subject).to have_received(:cast).once
      end
    end
  end
end
