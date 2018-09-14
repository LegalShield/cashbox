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

  context '#response' do
    let(:block) { double("block", call: true) }
    subject { Cashbox::Request.new(:method, 'path', { option: true }) }

    before do
      Cashbox.password = 'sekret'
      Cashbox.username = 'me'

      allow(Cashbox::Request).to receive(:send).with(:method, 'path', {
        option: true,
        basic_auth: { username: 'me', password: 'sekret' },
        timeout: 100
      })
    end

    context 'is defined' do
      it 'is called' do
        allow(Cashbox::Request).to receive(:after_request_log_block).and_return(block)
        subject.response

        expect(block).to have_received(:call)
      end
    end

    context 'is not defined' do
      it 'is not called' do
        allow(Cashbox::Request).to receive(:after_request_log_block).and_return(nil)
        subject.response

        expect(block).not_to have_received(:call)
      end
    end
  end

  def return_block(&block)
    block
  end

  describe ".after_request_log" do
    let(:block) do
      return_block do
      end
    end

    it "assigns the block if one is given" do
      Cashbox::Request.class_variable_set(:@@after_request_log, nil)

      Cashbox::Request.after_request_log(&block)

      expect(Cashbox::Request.class_variable_get(:@@after_request_log)).to eq(block)
    end

    it "assigns the block if one is not given" do
      Cashbox::Request.class_variable_set(:@@after_request_log, nil)

      Cashbox::Request.after_request_log

      expect(Cashbox::Request.class_variable_get(:@@after_request_log)).to eq(nil)
    end
  end
end
