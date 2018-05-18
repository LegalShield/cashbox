module Cashbox::Rest
  module StaticRepositry
    def repository
      Cashbox::Repository.new(self.new)
    end
  end
end
