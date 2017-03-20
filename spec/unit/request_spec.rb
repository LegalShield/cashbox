require 'spec_helper'

describe Vindicia::Request do
  context 'includes' do
    subject { Vindicia::Request.new(:get, '/path') }

    it 'HTTParty' do
      expect(subject).to be_a HTTParty
    end
  end

  context 'config' do
    subject { Vindicia::Request }
    its(:format) { is_expected.to eql(:json) }
    its(:base_uri) { is_expected.to eql('https://api.vindicia.com') }
  end

  context '#perform' do
    subject { Vindicia::Request.new(:method, 'path', { option: true }) }

    before do
      Vindicia.password = 'sekret'
      Vindicia.username = 'me'

      allow(Vindicia::Request).to receive(:send).with(:method, 'path', {
        option: true,
        basic_auth: { username: 'me', password: 'sekret' }
      })

      subject.perform
    end

    it 'makes the correct HTTP verb call' do
      expect(Vindicia::Request).to have_received(:send).with(:method, kind_of(String), kind_of(Hash))
    end

    it 'calls the correct path' do
      expect(Vindicia::Request).to have_received(:send).with(kind_of(Symbol), 'path', kind_of(Hash))
    end

    it 'passes the correct options' do
      expect(Vindicia::Request).to have_received(:send).with(kind_of(Symbol), kind_of(String), {
        option: true,
        basic_auth: {
          username: 'me',
          password: 'sekret'
        }
      })
    end
  end

end
