module Cashbox::Rest
  module Read
    extend(Cashbox::Rest::StaticRepositry) unless kind_of?(Cashbox::Rest::StaticRepositry)
    extend(SingleForwardable) unless kind_of?(SingleForwardable)

    def_single_delegators :repository, :where, :all, :first, :find
  end
end
