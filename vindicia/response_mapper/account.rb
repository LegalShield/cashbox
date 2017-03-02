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
#{
        #"object"=>"Account",
        #"id"=>"105-1486763198",
        #"vid"=>"570c2f4053ba985a5cbe19abb6fa7835906f9ce6",
        #"created"=>"2017-02-10T13:46:39-08:00",
        #"default_currency"=>"USD",
        #"email_type"=>"html",
        #"notify_before_billing"=>false,
        #"payment_methods"=>{
            #"object"=>"List",
            #"data"=>[
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
            #],
            #"total_count"=>1
        #}
    #},
