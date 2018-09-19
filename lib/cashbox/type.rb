module Cashbox::Type
  def self.List(type)
    @list ||= {}
    @list[type] ||= -> (data) do
      data = data.is_a?(Hash) ? data['data'] : data
      data.map { |value| type.new(value) }
    end
    @list[type]
  end

  def self.DateTime
    @date_time ||= -> (value) { value.is_a?(DateTime) ? value : DateTime.parse(value) }
  end

  def self.Boolean
    @boolean ||= -> (value) do
      case value
      when String
        !!(value =~ /\A(true|t|yes|y|1)\z/i)
      when Numeric
        !value.to_i.zero?
      else
        value == true
      end
    end
  end

  def self.Metadata
    @metadata = {
      "vin:MandateFlag" => "1",
      "vin:MandateVersion" => "1.0",
      "vin:MandateBankName" => "",
      "vin:MandateID" => "123456789"
    }
  end
end
