require 'spec_helper'

describe Vindicia do
  it 'has a version number' do
    expect(Vindicia::VERSION).not_to be nil
  end

  it { should have_attr_accessor(:username) }
  it { should have_attr_accessor(:password) }

  it 'sets sandbox values' do
    Vindicia.sandbox!
    expect(Vindicia::Repository.base_uri).to eql('https://api.prodtest.vindicia.com')
  end
end
