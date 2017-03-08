module Vindicia::ResponseMapper
  class BillingPlan < Base
    def map
      attributes = @response.slice('id', 'vid', 'description', 'status', 'billing_notification_days', 'billing_descriptor')

      attributes['created'] = DateTime.parse(@response['created']) if @response['created']
      attributes['periods'] = self.class.map(@response['periods']) if @response['periods']

      model_klass.new(attributes)
    end
  end
end
