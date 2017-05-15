module Vindicia
  class Criteria
    #extend Forwardable
    #def_instance_delegators :repository, :each, :to_a, :first
    extend Forwardable
    def_instance_delegators :exec, :to_a

    def initialize(repository)
      @repository = repository
      @where = { }
      @limit = 100
    end

    def where(hash = {})
      @where.merge!(hash)
      self
    end

    def limit(limit = 100)
      @limit = limit
      self
    end

    def first
      @limit = 1
      _exec.first
    end

    def to_query
      @where.merge({ limit: @limit })
    end

    def _exec
      @repository.where(self.to_query)
    end

    def all
      @repository.where({})
    end

    private

    def exec
      @repository.where(@where.merge({ limit: @limit }))
    end
  end
end
