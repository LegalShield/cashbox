module Vindicia::ResponseMapper
  class BillingPlan < Base
    def map(response)
      attributes = response.slice(:id, :vid, :created, :description, :status, :billing_notification_days, :billing_descriptor)

      attributes[:created] = DateTime.parse(attributes[:created]) if attributes[:created]
      attributes[:periods] = _map(response[:periods]) if response[:periods]

      instance.update_attributes(attributes)
    end
  end
end
