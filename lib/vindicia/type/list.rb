module Vindicia::Type
  class List < Array
    def self.proc_for(type)
      -> (d) { d['data'].map { |v| type.new(v) } }
    end
  end
end
