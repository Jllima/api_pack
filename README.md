[![Gem Version](https://badge.fury.io/rb/api_pack.svg)](https://badge.fury.io/rb/api_pack)
[![Build Status](https://travis-ci.org/Jllima/api_pack.svg?branch=master)](https://travis-ci.org/Jllima/api_pack)
[![Coverage Status](https://coveralls.io/repos/github/Jllima/api_pack/badge.svg?branch=master)](https://coveralls.io/github/Jllima/api_pack?branch=master)

# ApiPack

ApiPack is a set of helpers to Api rails

**This project provides the following helpers**

  - Json Web Token helpers
  - Json Api especifications
  - Errors Serializers
  - Pagination links Serializers
  - Serializer Adapter (BETA)

## Compatibility
```
ruby >= 2.4
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api_pack', '~> 1.1.1' 
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_pack

## Usage

### JsonWebToken methods
  
- ApiPack::JsonWebToken.encode({ user_id: user.id }) \
returns a valid token with an expiration time of one day
- To change o expiration create an initializer api_pack and put this code
```ruby
ApiPack.exp = 12345
```

Usage in a service authenticate user

ApiPack use gem JWT

```ruby
class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    # return token valid
    ApiPack::JsonWebToken.encode({ user_id: user.id }) if user
  end
  
  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    # raise AuthenticationError if authenticate fail
    raise(ApiPack::Errors::Auth::AuthenticationError, 'Invalid credentials')
  end
end
```

- ApiPack::JsonWebToken.decode(http_auth_header)

Usage in a service authorize api request

```ruby
class AuthorizeApiRequest
    def initialize(headers: {})
      @headers = headers
    end

    def call
      { user: user }
    end

    private

    attr_accessor :headers

    def user
      @user ||= User.find(decoded_auth_token['user_id']) if decoded_auth_token
    rescue ActiveRecord::RecordNotFound => e
      # raise InvalidToken if user not found
      raise ApiPack::Errors::Auth::InvalidToken, ("Invalid token #{e.message}")
    end

    def decoded_auth_token
      # decode a token valid
      @decoded_auth_token ||= ApiPack::JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      return headers['Authorization'].split(' ').last if headers['Authorization'].present?

      raise(ApiPack::Errors::Auth::MissingToken, 'Missing token')
    end
  end
```

### Errors Serializers

- Errors handled \
ActiveRecord::RecordNotFound \
ActionController::ParameterMissing \
ActiveRecord::RecordInvalid

- ApiPack::Errors::HandleError.new(e).call

create an ExceptionHandler concern and deal with api errors in json api format

```ruby
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      result = ApiPack::Errors::HandleError.new(e).call
      render json: result[:body], status: result[:status]
    end
  end
end
```

### Serializer Parser Adapter (BETA)

This Parser aims to provide adapters for using serializers like FastJsonApi

Default is FastJsonApi

By convection the serializers should be in

serializers/name_serializer/class_serializer

Ex: serializers/fast_jsonapi/user_serializer.rb

USAGE:
 - Create initializer serilializer_parser.rb and put this code
 
 
```ruby
ApiPack::Serializer::Parser.adapter = :fast_json_api
```

 - include ApiPack::ApiHelper in aplication_controler.rb

```ruby
 class ApplicationController < ActionController::API
  include ApiPack::ApiHelper
end
```
  - use method serializer_hash to return an hash

```ruby
def index
  users = User.all

  render json: serializer_hash(users, :user)
end
```
## Pagination Links
- pagination_meta_generator \
  Return an hash with pagination links
-  Apipack has default per page like 10
- To change o defaut_per_page create an initializer api_pack and put this code

```ruby
ApiPack.defaut_per_page = 12
```

```ruby
def index
  # current_page mtehod default is 1
  # per_page method default is 10
  users = User.page(current_page).per_page(per_page)

  options = pagination_meta_generator(request, users.total_pages)

  render json: serializer_hash(users, :user, opt: options)
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/api_pack.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
