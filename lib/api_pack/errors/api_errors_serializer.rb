module ApiPack
  module Errors
    class ApiErrorsSerializer
      def initialize(body)
        @body = body
      end

      def serializer
        serializable
      end

      private

      attr_accessor :body

      def serializable
        return serializable_array if body[:details].is_a?(Array)

        serializable_object
      end

      def serializable_object
        {
          errors: [
            body
          ]
        }
      end

      def serializable_array
        {
          title: body[:title],
          status: body[:status],
          errors: body[:details]
        }
      end
    end
  end
end
