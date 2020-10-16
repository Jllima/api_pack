module ApiPack
  module Errors
    class HandleError
      include Errors::ErrorMap

      def initialize(error)
        @error = error
      end

      def call
        handle_error
      end

      private

      attr_accessor :error

      def handle_error
        if ERROR_MAP.keys.include? error.class.name
          handler = ERROR_MAP[error.class.name]
          body = send(handler[:method], handler: handler, error: error)
        else
          body = {
            title: 'Internal Server Error',
            detail: error.message,
            status: :internal_server_error
          }
        end

        { body: serialize(body), status: body[:status] }
      end

      def serialize(body)
        Errors::ApiErrorsSerializer.new(body).serializer
      end

      def error_message_body(handler:, error:)
        {
          title: handler[:title],
          status: handler[:status],
          details: error.message
        }
      end

      def parameter_missing(handler:, error:)
        {
          title: handler[:title],
          details: error.message,
          status: handler[:status],
          parameter: error.param
        }
      end

      def record_invalid(handler:, error:)
        {
          title: handler[:title],
          status: handler[:status],
          details: Errors::ValidationErrorsSerializer.new(error.record).serialize
        }
      end
    end
  end
end
