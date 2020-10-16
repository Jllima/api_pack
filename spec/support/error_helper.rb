module ErrorHelper
  def body_authenticate_error
    {
      body: {
        errors: [
          {
            title: 'Invalid Credentials',
            status: :unauthorized,
            details: 'Errors::Auth::AuthenticationError'
          }
        ]
      },
      status: :unauthorized
    }
  end

  def body_invalid_token_error
    {
      body: {
        errors: [
          {
            title: 'Invalid Token',
            status: :unprocessable_entity,
            details: 'Errors::Auth::InvalidToken'
          }
        ]
      },
      status: :unprocessable_entity
    }
  end

  def body_missing_token_error
    {
      body: {
        errors: [
          {
            title: 'Missing Token',
            status: :unprocessable_entity,
            details: 'Errors::Auth::MissingToken'
          }
        ]
      },
      status: :unprocessable_entity
    }
  end
end