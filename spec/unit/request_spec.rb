require 'spec_helper'

describe Cashbox::Request do
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

  context '#perform' do
    subject { Cashbox::Request.new(:method, 'path', { option: true }) }

    before do
      Cashbox.password = 'sekret'
      Cashbox.username = 'me'

      allow(Cashbox::Request).to receive(:send).with(:method, 'path', {
        option: true,
        basic_auth: { username: 'me', password: 'sekret' },
        timeout: 100
      })

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

  context 'logging block' do
    let(:block) do end
    subject { Cashbox::Request.new(:method, 'path', { option: true }) }

    before do
      Cashbox.password = 'sekret'
      Cashbox.username = 'me'

      allow(Cashbox::Request).to receive(:send).with(:method, 'path', {
        option: true,
        basic_auth: { username: 'me', password: 'sekret' },
        timeout: 100
      }).and_return({msg:"hello"})

      allow(block).to receive(:call).with(any_args)
    end

    context 'is defined' do
      it 'is called' do
        allow(Cashbox::Request).to receive(:after_request_log_block).and_return(block)
        Cashbox::Request.after_request_log(&block)
        subject.response

        expect(block).to have_received(:call).with(any_args)
      end
    end

    context 'is not defined' do
      it 'is not called' do
        subject.response

        expect(block).not_to have_received(:call)
      end
    end
  end

end
