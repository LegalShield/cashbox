module Cashbox
  class Criteria
    #extend Forwardable
    #def_instance_delegators :repository, :each, :to_a, :first
    #extend Forwardable
    #def_instance_delegators :exec, :to_a

    def initialize(repository)
      @repository = repository
      @query = { }
    end

    def where(hash = {})
      @query.merge!(hash)
      self
    end

    def limit(limit = 100)
      where({ limit: limit })
    end

    def first
      where({ limit: 1 })
      exec.first
    end

    def all
      @repository.where({})
    end

    def explain
      @query
    end

    private

    def exec
      @repository.where(@query)
    end
  end
end
