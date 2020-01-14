module Yugo
  class Error
    attr_reader :message

    def initialize(msg)
      @message = msg.to_s.freeze
    end
  end
end
