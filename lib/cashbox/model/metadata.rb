module Cashbox
  class Metadata < Model
    property :mandate_Flag, from: "vin:MandateFlag", default: "1"
    property :mandate_version, from: "vin:MandateVersion", default: "1.0"
    property :mandate_bank_name, from: "vin:MandateBankName", default: ""
    property :mandate_id, from: "vin:MandateID", default: (Time.now.to_f * 1000000).to_i.to_s
  end
end
