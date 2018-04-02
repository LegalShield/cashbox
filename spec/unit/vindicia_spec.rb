require 'spec_helper'

describe Cashbox do
  it 'has a version number' do
    expect(Cashbox::VERSION).not_to be nil
  end

  it 'sets the base url of the request object' do
    expect(Cashbox::Request.base_uri).to eql('https://api.vindicia.com')
  end

  it { is_expected.to have_attr_accessor(:username) }
  it { is_expected.to have_attr_accessor(:password) }

  context '#configure' do
    context 'with a block' do
      subject { Cashbox }

      before do
        subject.config do |c|
          c.username = 'who'
          c.password = 'sekret'
        end
      end

      its(:username) { is_expected.to eq('who') }
      its(:password) { is_expected.to eq('sekret') }
    end

    context 'with a hash' do
      subject { Cashbox }

      before do
        subject.config({ username: 'name', password: 'so sekret' })
      end

      its(:username) { is_expected.to eq('name') }
      its(:password) { is_expected.to eq('so sekret') }
    end
  end

  context '.production!' do
    subject { Cashbox }
    before { subject.production! }

    it 'sets sandbox values' do
      expect(Cashbox::Request.base_uri).to eql('https://api.vindicia.com')
    end
  end

  context '.sandbox!' do
    subject { Cashbox }
    before { subject.sandbox! }
    after { subject.production! }

    it 'sets sandbox values' do
      expect(Cashbox::Request.base_uri).to eql('https://api.prodtest.vindicia.com')
    end
  end

  context '.test!' do
    subject { Cashbox }
    before { subject.test! }
    after { subject.production! }

    its(:username) { is_expected.to eql('username') }
    its(:password) { is_expected.to eql('password') }

    it 'sets the base url of the request object' do
      expect(Cashbox::Request.base_uri).to eql('http://example.com')
    end
  end

  context '.debug!' do
    subject { Cashbox }

    it 'sets the debug strategy to $stdout' do
      expect(Cashbox::Request.default_options[:debug_output]).to be_nil
      subject.debug!
      expect(Cashbox::Request.default_options[:debug_output]).to eq($stdout)
    end
  end
end
