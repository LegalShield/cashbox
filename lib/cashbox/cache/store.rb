module Cashbox::Cache
  class Store
    def get(key)
      NotImplementedError.new("#{self.class.name} does not support #get")
    end

    def set(key, value)
      NotImplementedError.new("#{self.class.name} does not support #set")
    end

    def delete(key)
      NotImplementedError.new("#{self.class.name} does not support #delete")
    end
  end
end
