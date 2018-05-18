require 'httparty'
require 'hashie'
require 'active_support/dependencies/autoload'

module Cashbox
  extend ActiveSupport::Autoload

  class << self
    attr_accessor :username, :password

    def config(hash = {})
      if block_given?
        yield(self)
      else
        hash.each { |k, v| self.send("#{k}=", v) }
      end
    end

  end

  def self.production!
    Cashbox::Request.base_uri('https://api.vindicia.com')
  end

  def self.sandbox!
    Cashbox::Request.base_uri('https://api.prodtest.vindicia.com')
  end

  def self.development!
    Cashbox::Request.base_uri('https://api.prodtest.vindicia.com')
  end

  def self.test!
    Cashbox.username = 'username'
    Cashbox.password = 'password'
    Cashbox::Request.base_uri('http://example.com')
  end

  def self.debug!
    Cashbox::Request.debug_output $stdout
  end

  eager_autoload do
    autoload :VERSION
    autoload :Error
    autoload :Type
    autoload :Request
    autoload :Repository

    autoload_under 'model' do
      autoload :Model
      autoload :Account
      autoload :Address
      autoload :BillingPlan
      autoload :BillingPlanPeriod
      autoload :CreditCard
      autoload :Description
      autoload :DirectDebit
      autoload :Entitlement
      autoload :Invoice
      autoload :InvoiceItem
      autoload :PayPal
      autoload :PaymentMethod
      autoload :Period
      autoload :Price
      autoload :Product
      autoload :ProductDescription
      autoload :ProductPrice
      autoload :Subscription
      autoload :SubscriptionItem
      autoload :Transaction
      autoload :TransactionItem
      autoload :TransactionStatus
      autoload :TransactionStatusPayPal
    end
  end

  module Rest
    autoload :Read, 'cashbox/rest/read'
    autoload :StaticRepositry, 'cashbox/rest/static_repository'
  end

  module Concern
    autoload :Objectable, 'cashbox/concern/objectable'
    autoload :Persistable, 'cashbox/concern/persistable'
  end
end
