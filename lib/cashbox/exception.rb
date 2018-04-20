module Cashbox
  class Exception < Exception
  end

  #An error thrown when a save to the billing client fails.
  class SaveError < StandardError
    def initialize(message)
      super(message)
    end
  end
end
