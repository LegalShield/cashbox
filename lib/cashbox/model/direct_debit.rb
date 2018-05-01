module Cashbox
  class DirectDebit < Model
    include Concern::Objectable
    include Concern::Persistable

    property :vid
    property :account
    property :account_length
    property :bank_sort_code
    property :country_code
  end
end
