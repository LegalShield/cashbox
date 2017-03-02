module Vindicia::ResponseMapper
  class SubscriptionItem < Base
    def map(response)
      attributes = response.slice(:vid, :quantity)

      attributes[:created] = DateTime.parse(response[:created]) if response[:created]
      attributes[:starts]  = DateTime.parse(response[:starts])  if response[:starts]
      attributes[:product] = _map(response[:product])           if response[:product]

      instance.update_attributes(attributes)
    end
  end
end
