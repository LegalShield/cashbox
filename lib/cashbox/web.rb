require 'sinatra'
require 'sinatra/base'

module Cashbox
  class Web < Sinatra::Base
    set :root, File.expand_path('../web', __FILE__)
    set :views, settings.root + '/views'

    get '/credit_cards/new' do
      @address = params[:address] || {}
      erb :credit_card
    end
  end
end



  #class_attribute :javascript_url
  #class_attribute :private_key


  #get '*' do
    #'hello'
  #end



      #use Digest::SHA qw(hmac_sha256_hex hmac_sha512_hex);
      #my $private_key = "A39485F85039D394059B948390"; // will be issued to you by Vindicia
      #my $session_id= "MySessionID"; // unique session ID chosen by you for every new form submission
      #my $signed_session_id = hmac_sha256_hex("$session_id#POST#/payment_methods", $private_key);
      #print "$signed_session_id\n";

      #Let’s say the signed session ID is as below:
        #27bb4ee393cb36926a8d368053f30512972e495ce9ecd21c4e9cbb5602ac951b
