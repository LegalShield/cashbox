module Vindicia::ResponseMapper
  class Base
    def initialize(response)
      @response = response
    end

    def self.map(response)
      case response['object']
      when 'List'
        response['data'].map {|d| map(d) }
      when 'Error'
        puts response
      else
        "Vindicia::Model::#{response['object']}".constantize.new(response)
      end
    end

    private

    def model_klass
      "Vindicia::Model::#{self.class.name.split('::').last}".constantize
    end
  end
end
