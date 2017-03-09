module Vindicia::RequestMapper
  class Subscription < Base
    def_delegators :@model, :id

    def account
      _present(@model.account) if @model.account
    end

    def billing_plan
      _present(@model.billing_plan) if @model.billing_plan
    end

    def items
      (@model.items || []).map do |item|
        _present(item)
      end
    end

    def payment_method
      @model.payment_method
    end
  end
end
