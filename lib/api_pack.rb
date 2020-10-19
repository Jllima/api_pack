require 'jwt'
require 'fast_jsonapi'
require 'api_pack/version'
require 'api_pack/json_web_token'
require 'api_pack/pagination_meta_generator'
require 'api_pack/errors/auth'
require 'api_pack/errors/error_map'
require 'api_pack/errors/handle_error'
require 'api_pack/errors/api_errors_serializer'
require 'api_pack/errors/validation_error_serializer'
require 'api_pack/errors/validation_errors_serializer'
require 'api_pack/constants'
require 'api_pack/support/api_helper'
require 'api_pack/serializer/parser'

module ApiPack
  module_function

  PER_PAGE = 10
  # 24 hours from now
  DEFAULT_EXP = (Time.now + 1 * 86_400).to_i

  attr_writer :default_per_page, :exp

  def default_per_page
    @default_per_page ||= PER_PAGE
  end

  def exp
    @exp ||= DEFAULT_EXP
  end

  def serializer_adapter=(adapter)
    ApiPack::Serializer::Parser.adapter = adapter
  end
end
