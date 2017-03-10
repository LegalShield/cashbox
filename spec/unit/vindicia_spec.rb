require 'spec_helper'

describe Vindicia do
  it 'has a version number' do
    expect(Vindicia::VERSION).not_to be nil
  end

  it { should have_attr_accessor(:username) }
  it { should have_attr_accessor(:password) }

  it 'sets sandbox values' do
    Vindicia.sandbox!
    expect(Vindicia::Request.base_uri).to eql('https://api.prodtest.vindicia.com')
  end

  it 'sets test values' do
    Vindicia.test!
    expect(Vindicia::Request.base_uri).to eql('http://example.com')
    expect(Vindicia.username).to eql('username')
    expect(Vindicia.password).to eql('password')
  end
end
