require 'spec_helper'

describe Vindicia::RepositoryProxy do

  context 'init' do
    subject { Vindicia::RepositoryProxy.new }

    it 'inits with a model' do
      expect(-> { subject }).to raise_exception(ArgumentError)
    end
  end

  context '#repository' do
    it 'returns the Accout repository for the Account model' do
      repository_proxy = Vindicia::RepositoryProxy.new(Vindicia::Account.new)
      expect(repository_proxy.repository).to be_a(Vindicia::Repository::Account)
    end
  end

  #context 'includes' do
    #subject { Vindicia::Request.new(:get, '/path') }

    #it 'HTTParty' do
      #expect(subject).to be_a HTTParty
    #end
  #end

  #context 'config' do
    #subject { Vindicia::Request }
    #its(:format) { is_expected.to eql(:json) }
    #its(:base_uri) { is_expected.to eql('https://api.vindicia.com') }
  #end

  #context '#perform' do
    #subject { Vindicia::Request.new(:method, 'path', { option: true }) }

    #before do
      #Vindicia.password = 'sekret'
      #Vindicia.username = 'me'

      #allow(Vindicia::Request).to receive(:send).with(:method, 'path', {
        #option: true,
        #basic_auth: { username: 'me', password: 'sekret' }
      #})

      #subject.response
    #end

    #it 'makes the correct HTTP verb call' do
      #expect(Vindicia::Request).to have_received(:send).with(:method, kind_of(String), kind_of(Hash))
    #end
  #end
end
