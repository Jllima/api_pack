module ApiPack
  module Errors
    class ValidationErrorsSerializer
      attr_reader :record

      def initialize(record)
        @record = record
      end

      def serialize
        record.errors.messages.map do |field, messages|
          messages.map do |error_messages|
            ApiPack::Errors::ValidationErrorSerializer.new(record, field, error_messages).serialize
          end
        end.flatten
      end
    end
  end
end
