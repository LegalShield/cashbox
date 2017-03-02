module Vindicia::Repository
  class PaymentMethod < Base

    private

    def _route
      '/payment_methods'
    end
  end
end
