module Vindicia::Model
  class Account < Base
    include Vindicia::Concern::Persistable

    attr_accessor :id,
                  :vid,
                  :created,
                  :default_currency,
                  :email,
                  :email_type,
                  :name,
                  :notify_before_billing

    def initialize(attributes = {})
      super
      self.default_currency = 'USD'
      self.notify_before_billing = false
      self.created = TimeDate.parse(self.created) if self.created
    end
  end
end
