require 'httparty'
require 'hashie'
require 'active_support/dependencies/autoload'

module Cashbox
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :VERSION
    autoload :Error
    autoload :Type
    autoload :Request
    autoload :Rest
    autoload :Cache

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
      autoload :Metadata
      autoload :PayPal
      autoload :PaymentMethod
      autoload :Period
      autoload :Price
      autoload :Product
      autoload :ProductDescription
      autoload :ProductPrice
      autoload :Refund
      autoload :Subscription
      autoload :SubscriptionItem
      autoload :Transaction
      autoload :TransactionItem
      autoload :TransactionStatus
      autoload :TransactionStatusPayPal
    end
  end

  module Concern
    autoload :Objectable, 'cashbox/concern/objectable'
    autoload :Persistable, 'cashbox/concern/persistable'
  end

  class << self
    attr_accessor :username, :password

    delegate :cache_store=, :cache_store, to: Cashbox::Cache

    def config(&block)
      self::Request.before_request_hooks ||= []
      self::Request.after_request_hooks  ||= []
      self::Cache.cache_store            ||= Cashbox::Cache::NullStore.new

      block.call(self)
    end

    def before_request(&block)
      self::Request.before_request_hooks << block
    end

    def after_request(&block)
      self::Request.after_request_hooks << block
    end

    def base_uri=(value)
      self::Request.base_uri(value)
    end

    def debug!
      self::Request.debug_output $stdout
    end

    def production!
      self.config do |c|
        c.base_uri = 'https://api.vindicia.com'
      end
    end

    def sandbox!
      self.config do |c|
        c.base_uri = 'https://api.prodtest.vindicia.com'
      end
    end

    def development!
      self.config do |c|
        c.base_uri = 'https://api.prodtest.vindicia.com'
      end
    end

    def test!
      self.config do |c|
        c.username = 'username'
        c.password = 'password'
        c.base_uri = 'http://example.com'
      end
    end
  end
end
