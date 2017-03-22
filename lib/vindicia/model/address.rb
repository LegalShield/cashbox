module Vindicia::Model
  class Address < Base
    include Vindicia::Model::Concern::Objectable

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
