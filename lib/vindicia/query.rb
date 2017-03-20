module Vindicia
  class Query < Hashie::Clash
    def self.where(*args)
      self.new.where(*args)
    end

    def self.limit(*args)
      self.new.limit(*args)
    end

    def each(&block)

    end

    def to_a

    end

    def count

    end

    def first

    end
  end
end
