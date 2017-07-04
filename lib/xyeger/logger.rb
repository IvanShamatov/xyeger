module Xyeger
  class Logger < ActiveSupport::Logger
    Logger::Severity.constants.each do |severity|
      define_method severity.downcase do |message=nil, context=nil, &block|
        context, message = message, context if message.is_a?(Hash)

        if block
          result = block.call

          if result.is_a?(Hash)
            context = result
          else
            message = result
          end
        end
        add(Logger::Severity.const_get(severity), message, context)
      end
    end
  end
end
