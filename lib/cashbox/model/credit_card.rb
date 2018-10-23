module Cashbox
  class CreditCard < Model
    include Concern::Objectable

    MASTER_CARD = 'MasterCard'
    VISA = 'Visa'

    BIN_PREFIXES = {
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
