module Vindicia::Type
  class DateTime < DateTime
    def self.coerce(value)
      self.parse(value)
    end
  end
end
