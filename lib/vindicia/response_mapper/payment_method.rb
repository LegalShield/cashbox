module Vindicia::ResponseMapper
  class PaymentMethod < Base
    def map(response)
      attributes = response.slice(:object, :id, :vid, :created, :type, :promary, :active)

      attributes[:created] = DateTime.parse(attributes[:created]) if attributes[:created]
      attributes[:paypal]  = _map(response[:paypal])              if response[:paypal]

      instance.update_attributes(attributes)
    end
  end
end
                #{
                    #"object"=>"PaymentMethod",
                    #"vid"=>"e7a75dcfa3df7f255a80089d535eff857ba070a7",
                    #"created"=>"2017-02-10T13:46:50-08:00",
                    #"type"=>"PayPal",
                    #"paypal"=>{
                        #"object"=>"PayPal",
                        #"return_url"=>"http://localhost:3000/success?test=1",
                        #"cancel_url"=>"http://localhost:3000/cancel",
                        #"request_reference_id"=>true,
                        #"reference_id"=>nil
                    #},
                    #"primary"=>true,
                    #"active"=>true
                #}
