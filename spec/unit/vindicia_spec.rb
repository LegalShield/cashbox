require 'spec_helper'

describe Vindicia do
  it 'has a version number' do
    expect(Vindicia::VERSION).not_to be nil
  end

  it { is_expected.to have_attr_accessor(:username) }
  it { is_expected.to have_attr_accessor(:password) }

  context '#configure' do
    context 'with a block' do
      subject { Vindicia }

      before do
        Vindicia.config do |c|
          c.username = 'who'
          c.password = 'sekret'
        end
      end

      its(:username) { is_expected.to eq('who') }
      its(:password) { is_expected.to eq('sekret') }
    end

    context 'with a hash' do
      subject { Vindicia }

      before do
        Vindicia.config({ username: 'name', password: 'so sekret' })
      end

      its(:username) { is_expected.to eq('name') }
      its(:password) { is_expected.to eq('so sekret') }
    end
  end

  context '.sandbox!' do
    subject { Vindicia }
    before { Vindicia.sandbox! }

    it 'sets sandbox values' do
      expect(Vindicia::Request.base_uri).to eql('https://api.prodtest.vindicia.com')
    end
  end

  context '.test!' do
    subject { Vindicia }
    before { Vindicia.test! }
    its(:username) { is_expected.to eql('username') }
    its(:password) { is_expected.to eql('password') }

    it 'sets the base url of the request object' do
      expect(Vindicia::Request.base_uri).to eql('http://example.com')
    end
  end
end
