module Vindicia::ResponseMapper
  class Product < Base
    def map
      attributes = {}
      #attributes = @response.slice(:id, :vid, :billing_descriptor, :credit_granted)

      attributes['created']              = DateTime.parse(@response['created'])              if @response['created']
      attributes['descriptions']         = self.class.map(@response['descriptions'])         if @response['descriptions']
      attributes['entitlements']         = self.class.map(@response['entitlements'])         if @response['entitlements']
      attributes['prices']               = self.class.map(@response['prices'])               if @response['prices']
      attributes['default_billing_plan'] = self.class.map(@response['default_billing_plan']) if @response['default_billing_plan']

        #.update_attributes(attributes)
      model_klass.new
    end
  end
end
