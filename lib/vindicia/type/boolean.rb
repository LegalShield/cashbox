module Vindicia::Type
  class Boolean
    def self.coerce(value)
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
