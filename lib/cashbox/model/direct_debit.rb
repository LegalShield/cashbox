module Cashbox
  class DirectDebit < Model
    include Concern::Objectable

    property :vid
    property :account
    property :account_length
    property :bank_sort_code
    property :country_code
    property :last_digits
    property :rib_code
  end
end
