module ApiPack
  module Errors
    class ValidationErrorSerializer
      def initialize(record, field, message)
        @record = record
        @field = field
        @message = message
      end

      def serialize
        {
          resource: underscored_resource_name,
          field: @field,
          detail: @message
        }
      end

      private

      def underscored_resource_name
        @record.class.to_s.gsub('::', '').underscore
      end
    end
  end
end
