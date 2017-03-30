module Vindicia
  class Critiera
    def initialize
      @where = {}
      @limit = 100
    end

    def where(hash = {})
      @where.merge!(hash)
      self
    end

    def limit(limit = 100)
      @limit = 100
    end

    def first

    end

    def to_a

    end
  end
end
