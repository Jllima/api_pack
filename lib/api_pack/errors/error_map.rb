module ApiPack
  module Errors
    module ErrorMap
      ERROR_MAP = {
        'ActiveRecord::RecordNotFound' => {
          method: :error_message_body,
          title: 'Not Found',
          status: :not_found
        },
        'ActionController::ParameterMissing' => {
          method: :parameter_missing,
          title: 'Parameter Missing',
          status: :unprocessable_entity
        },
        'ActiveRecord::RecordInvalid' => {
          method: :record_invalid,
          title: 'Validations Failed',
          status: :unprocessable_entity
        },
        'ApiPack::Errors::Auth::AuthenticationError' => {
          method: :error_message_body,
          title: 'Invalid Credentials',
          status: :unauthorized
        },
        'ApiPack::Errors::Auth::InvalidToken' => {
          method: :error_message_body,
          title: 'Access Denied - Invalid Token',
          status: :forbidden
        },
        'ApiPack::Errors::Auth::MissingToken' => {
          method: :error_message_body,
          title: 'Missing Token',
          status: :unprocessable_entity
        }
      }.freeze
    end
  end
end
