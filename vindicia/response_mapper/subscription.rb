module Vindicia::ResponseMapper
  class Subscription < Base
    def map(response)

      attributes = response.slice(:object, :id, :vid, :status, :currency, :billing_state, :billing_day, :notify_on_transition)

      attributes[:created]             = DateTime.parse(response[:created])          if response[:created]
      attributes[:starts]              = DateTime.parse(response[:starts])           if response[:starts]
      attributes[:ends]                = DateTime.parse(response[:ends])             if response[:ends]
      attributes[:entitled_through]    = DateTime.parse(response[:entitled_through]) if response[:entitled_through]
      attributes[:account]             = _map(response[:account])                    if response[:account]
      attributes[:billing_plan]        = _map(response[:billing_plan])               if response[:billing_plan]
      attributes[:items]               = _map(response[:items])                      if response[:items]
      attributes[:payment_method]      = _map(response[:payment_method])             if response[:payment_method]
      attributes[:most_recent_billing] = _map(response[:most_recent_billing])        if response[:most_recent_billing]
      attributes[:next_billing]        = _map(response[:next_billing])               if response[:next_billing]

      instance.update_attributes(attributes)
    end
  end
end
