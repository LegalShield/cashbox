module Vindicia::Model
  class Product < Base
    #include Vindicia::Concern::Persistable

    attr_accessor :id,
                  :vid,
                  :created,
                  :descriptions,
                  :status,
                  :default_billing_plan,
                  :entitlements,
                  :billing_descriptor,
                  :credit_granted,
                  :prices

  end
end
