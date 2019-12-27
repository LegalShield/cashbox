module Cashbox
  class CreditCard < Model
    include Concern::Objectable

    DISCOVER = 'Discover'
    MASTER_CARD = 'MasterCard'
    VISA = 'Visa'

    BIN_PREFIXES = {
      '3' => DISCOVER,
      '6' => DISCOVER,
      '2' => MASTER_CARD,
      '5' => MASTER_CARD,
      '4' => VISA
    }

    property :vid
    property :account
    property :account_length
    property :bin
    property :expiration_date
    property :last_digits

    def network
      BIN_PREFIXES[bin.to_s[0]]
    end
  end
end
