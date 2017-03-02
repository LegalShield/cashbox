module Vindicia::RequestMapper
  class Account < Base
    delegate :id, :name, :email, :default_currency, :notify_before_billing, { to: :'@model' }
  end
end
