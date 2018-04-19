module Cashbox
  class ErrorMessages
    attr_accessor :messages

    def initialize
      @messages = {}
    end
  end

  class Model < Hashie::Trash
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::Dash::PropertyTranslation
    include Hashie::Extensions::Dash::Coercion

    property :message
    property :type
    property :code
    property :url

    def errors
      error_messages = ErrorMessages.new

      error_messages.messages = Hash[type, [message, code, url]]
      error_messages
    end
  end
end
