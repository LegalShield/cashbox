module Cashbox
  class Exception < Exception
  end

  class SaveError < StandardError
    def initialize(message)
      super(message)
    end
  end

end
