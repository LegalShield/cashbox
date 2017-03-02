module Vindicia::RequestMapper
  class Subscription < Base
    delegate :id, { to: '@model' }

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


#{
    #"object": "Subscription",
    #"id": "sub_1234",
    #"account": {
       #"object": "Account",
       #"id": "cust_1234"
    #},
    #"billing_plan": {
       #"object": "BillingPlan",
       #"id": "plan_1234"
    #},
    #"payment_method": {
       #"object": "PaymentMethod",
       #"id": "paym_1234"
    #},
    #"currency": "USD",
    #"description": "Subscription_1234",
    #"starts": "2016-05-27T05:52:02-07:00",
    #"items": [
       #{
          #"object": "SubscriptionItem",
          #"id": "sub_1234.1",
          #"product": {
             #"object": "Product",
             #"id": "prod_1234"
          #}
       #},
       #{
          #"object": "SubscriptionItem",
          #"id": "sub_1234.2",
          #"product": {
             #"object": "Product",
             #"id": "prod_1235"
          #}
       #}
    #],
    #"minimum_commitment": 0,
    #"policy": {
       #"ignore_cvn_policy": 1,
       #"ignore_avs_policy": 1,
       #"min_chargeback_probability": 99,
       #"immediate_auth_failure_policy": "doNotSaveAutoBill",
       #"validate_for_future_payment": 0
    #}
 #}
