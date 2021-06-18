require 'jwt'
require 'api_pack/version'
require 'api_pack/api_helper'
require 'api_pack/json_web_token'
require 'api_pack/pagination_meta_generator'
require 'api_pack/errors/auth'
require 'api_pack/errors/error_map'
require 'api_pack/errors/handle_error'
require 'api_pack/errors/api_errors_serializer'
require 'api_pack/errors/validation_error_serializer'
require 'api_pack/errors/validation_errors_serializer'
require 'api_pack/support/helper'
require 'api_pack/support/undescore'
require 'api_pack/serializer/parser'

module ApiPack
  module_function

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 5
  
  def default_per_page=(value)
    @default_per_page = value
  end

  def default_per_page
    @default_per_page ||= DEFAULT_PER_PAGE
  end

  def hmac_secret=(value)
    @hmac_secret = value
  end

  def hmac_secret
    @hmac_secret
  end

  def serializer_adapter=(adapter)
    ApiPack::Serializer::Parser.adapter = adapter
  end
end
