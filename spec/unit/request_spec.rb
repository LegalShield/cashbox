require 'spec_helper'

describe Cashbox::Request do
  before do
    Cashbox.config do |c|
      c.password = 'sekret'
      c.username = 'me'
    end
  end

  context 'includes' do
    subject { Cashbox::Request.new(:get, '/path') }

    it 'HTTParty' do
      expect(subject).to be_a HTTParty
    end
  end

  context 'config' do
    subject { Cashbox::Request }
    its(:format) { is_expected.to eql(:json) }
    its(:base_uri) { is_expected.to eql('https://api.vindicia.com') }
  end

  describe '#response' do
    before do
      allow(Cashbox::Request).to receive(:send).with(:method, 'path', {
        option: true,
        basic_auth: { username: 'me', password: 'sekret' },
        timeout: 100
      }).and_return(double('response', parsed_response: { }))
    end

    subject { Cashbox::Request.new(:method, 'path', { option: true }) }

    context 'making the request' do
      before do
        subject.response
      end

      it 'makes the correct HTTP verb call' do
        expect(Cashbox::Request).to have_received(:send).with(:method, kind_of(String), kind_of(Hash))
      end

      it 'calls the correct path' do
        expect(Cashbox::Request).to have_received(:send).with(kind_of(Symbol), 'path', kind_of(Hash))
      end

      it 'passes the correct options' do
        expect(Cashbox::Request).to have_received(:send).with(kind_of(Symbol), kind_of(String), {
          option: true,
          basic_auth: {
            username: 'me',
            password: 'sekret'
          },
          timeout: 100
        })
      end
    end

    skip 'before and after hooks' do
      before do
        Cashbox.before_request do |method, path, options|

        end

        Cashbox.after_request do |method, path, options, response|

        end
      end

      it '' do

      end
    end
  end
end
