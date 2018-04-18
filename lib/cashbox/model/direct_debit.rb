module Cashbox
  class DirectDebit < Model
    include Cashbox::Concern::Objectable

    property :account
    property :account_length
    property :bank_sort_code
    property :country_code
  end
end
