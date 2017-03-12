module Vindicia::Repository
  autoload :Base,          'vindicia/repository/base'
  autoload :Account,       'vindicia/repository/account'
  autoload :BillingPlan,   'vindicia/repository/billing_plan'
  autoload :PaymentMethod, 'vindicia/repository/payment_method'
  autoload :Product,       'vindicia/repository/product'
  autoload :Subscription,  'vindicia/repository/subscription'
  autoload :Transaction,   'vindicia/repository/transaction'
end
