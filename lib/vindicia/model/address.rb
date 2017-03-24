module Vindicia
  class Address < Model
    include Vindicia::Concern::Objectable

    property :vid
    property :city
    property :country
    property :district
    property :fax
    property :line1
    property :name
    property :phone
    property :postal_code
  end
end
