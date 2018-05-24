module Cashbox::Rest
  module All
    include Cashbox::Rest::Archive
    include Cashbox::Rest::Cancel
    include Cashbox::Rest::Basic
  end
end
