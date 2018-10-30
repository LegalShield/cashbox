require 'httparty'
require 'hashie'
require 'active_support/dependencies/autoload'

module Cashbox
  extend ActiveSupport::Autoload

  class << self
    attr_accessor :username, :password

    def config(&block)
      block.call(self)
    end

    def before_request(&block)
      Cashbox::Request.before_request_blocks << block
    end

    def after_request(&block)
      Cashbox::Request.after_request_blocks << block
    end

    def cache_store=(strategy = :null_strategy, options = {})
      binding.pry
      cache_store = case strategy
      when :null_store   then Cashbox::Cache::NullStore
      when :memory_store then Cashbox::Cache::MemoryStore
      end.new(options)
      Cashbox::Cache.cache_store = cache_store
    end

    def production!
      Cashbox::Request.base_uri('https://api.vindicia.com')
    end

    def sandbox!
      Cashbox::Request.base_uri('https://api.prodtest.vindicia.com')
    end

    def development!
      Cashbox::Request.base_uri('https://api.prodtest.vindicia.com')
    end

    def test!
      Cashbox.username = 'username'
      Cashbox.password = 'password'
      Cashbox::Request.base_uri('http://example.com')
    end

    def debug!
      Cashbox::Request.debug_output $stdout
    end
  end

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

  # this is bad, dunno where to put this atm
  Cashbox::Request.before_request_blocks = []
  Cashbox::Request.after_request_blocks = []
end
