module Vindicia::ResponseMapper
  class PayPal < Base
    def map(response)
      attributes = response.slice(:object, :return_url, :cancel_url, :request_reference_id, :reference_id)
      instance.update_attributes(attributes)
    end
  end
end
#{
    #"object"=>"PayPal",
    #"return_url"=>"http://localhost:3000/success?test=1",
    #"cancel_url"=>"http://localhost:3000/cancel",
    #"request_reference_id"=>true,
    #"reference_id"=>nil
#}
