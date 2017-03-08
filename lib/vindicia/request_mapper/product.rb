module Vindicia::RequestMapper
  class Product < Base
    def_delegators :@model, :id

    def default_billing_plan
      _present(@model.default_billing_plan) if @model.default_billing_plan
    end

    def descriptions
      (@model.descriptions || []).map do |description|
        _present(description)
      end
    end
  end
end
