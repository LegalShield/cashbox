module Vindicia::ResponseMapper
  class Account < Base
    def map(response)
      attributes = response.slice(:object, :id, :vid, :created, :name, :email_type, :email, :default_currency, :notify_before_billing)

      attributes[:created]         = DateTime.parse(attributes[:created]) if attributes[:created]
      attributes[:payment_methods] = _map(response[:payment_methods])     if response[:payment_methods]
      instance.update_attributes(attributes)
    end
  end
end
