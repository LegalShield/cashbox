module Vindicia::Repository
  class Base
    include HTTParty
    base_uri 'https://api.prodtest.vindicia.com'
    #debug_output $stderr
    format :json

    def first
      where({ limit: 1 }).first
    end

    def all
      where({})
    end

    def where(query = {})
      _map(_get(_route, { limit: 100 }.merge(query)))
    end

    def find(id)
      raise ArgumentError "Cannot find Resource with id 'nil'" unless id
      _map(_get(_get_route(id)))
    end

    def save(model)
      if model.vid
        _map(_post(_get_route(model.vid), _present(model)), model)
      else
        _map(_post(_route, _present(model)), model)
      end
    end

    private

    def _present(model)
      Vindicia::RequestMapper::Base._present(model)
    end

    def _map(response, instance = nil)
      Vindicia::ResponseMapper::Base.new._map(response.to_h.with_indifferent_access, instance)
    end

    def _get(route, query = {})
      self.class.get(route, { basic_auth: _auth, query: query })
    end

    def _post(route, body)
      self.class.post(route, { basic_auth: _auth, body: body.to_json })
    end

    def _auth
      { username: 'legalshield_soap', password: '50BGqQUvzW5VLLqoIbtcqeYQ94xWa1hW' }
    end

    def _get_route(id)
      "#{_route}/#{id}"
    end

    def _route
      throw 'define me in a subclass'
    end
  end
end
