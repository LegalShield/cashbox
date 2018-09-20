module Cashbox
  class Metadata < Model
    include Concern::Objectable

    property "vin:MandateFlag", default: "1"
    property "vin:MandateVersion", default: "1.0"
    property "vin:MandateBankName", default: "The Bank NA"
    property "vin:MandateID", default: (Time.now.to_f * 1000000).to_i.to_s
  end
end
