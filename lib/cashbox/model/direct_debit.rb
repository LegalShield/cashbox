module Cashbox
  class DirectDebit < Model
    include Concern::Objectable

    property :account
    property :account_length
    property :bank_sort_code
    property :country_code
    property :last_digits
    property :rib_code
    property :vid
  end
end
