module Vindicia::ResponseMapper
  class Product < Base
    def map(response)
      attributes = response.slice(:id, :vid, :billing_descriptor, :credit_granted, :created)
      attributes[:created] = DateTime.parse(attributes[:created]) if attributes[:created]

      attributes[:descriptions]         = _map(response[:descriptions])         if response[:descriptions]
      attributes[:entitlements]         = _map(response[:entitlements])         if response[:entitlements]
      attributes[:prices]               = _map(response[:prices])               if response[:prices]
      attributes[:default_billing_plan] = _map(response[:default_billing_plan]) if response[:default_billing_plan]

      instance.update_attributes(attributes)
    end
  end
end
