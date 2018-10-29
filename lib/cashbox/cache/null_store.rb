module Cashbox::Cache
  class NullStore < Store

    def initialize(*args); end
    def get(key); nil; end
    def set(key, value); value; end
    def delete(key); nil; end

  end
end
