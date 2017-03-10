module Vindicia::Type
  def self.List(type)
    @list ||= {}
    @list[type] ||= -> (data) { data['data'].map { |value| type.new(value) } }
    @list[type]
  end

  def self.DateTime
    @date_time ||= -> (value) {
      DateTime.parse(value)
    }
  end

  def self.Boolean
    @boolean ||= -> (value) {
      case value
      when String
        !!(value =~ /\A(true|t|yes|y|1)\z/i)
      when Numeric
        !value.to_i.zero?
      else
        value == true
      end
    }
  end
end
