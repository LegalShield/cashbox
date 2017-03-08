module Vindicia::RequestMapper
  class Account < Base
    def_delegators :@model, :id, :name, :email, :default_currency, :notify_before_billing
  end
end
