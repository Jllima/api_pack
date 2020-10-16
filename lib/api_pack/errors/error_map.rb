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
      'Errors::Auth::AuthenticationError' => {
        method: :error_message_body,
        title: 'Invalid Credentials',
        status: :unauthorized
      },
      'Errors::Auth::InvalidToken' => {
        method: :error_message_body,
        title: 'Invalid Token',
        status: :unprocessable_entity
      },
      'Errors::Auth::MissingToken' => {
        method: :error_message_body,
        title: 'Missing Token',
        status: :unprocessable_entity
      }
    }.freeze
  end
end
