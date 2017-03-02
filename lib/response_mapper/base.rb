module Vindicia::ResponseMapper
  class Base
    attr_reader :instance

    def initialize(instance = nil)
      @instance = instance
    end

    def map
      throw 'define in subclass'
    end

    def _map(response, instance = nil)
      case response[:object]
      when 'Error'
        puts response
        throw Vindicia::Exception.new(response[:message])
      else
        klass = "Vindicia::ResponseMapper::#{response[:object]}".constantize
        mapper = instance.nil? ? klass.new() : klass.new(instance)
        mapper.map(response)
      end
    end

    def instance
      @instance ||= "Vindicia::#{self.class.name.split('::').last}".constantize.new
    end
  end
end
