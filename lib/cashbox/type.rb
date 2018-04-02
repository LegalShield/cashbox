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
    @date_time ||= -> (value) { DateTime.parse(value) }
  end

  def self.BigDecimal
    @big_decimal ||= -> (value) { BigDecimal.new(value.to_s) }
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
end
