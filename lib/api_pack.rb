require 'jwt'
require 'api_pack/version'
require 'api_pack/json_web_token'
require 'api_pack/pagination_meta_generator'
require 'api_pack/errors/auth'
require 'api_pack/errors/error_map'
require 'api_pack/errors/handle_error'
require 'api_pack/errors/api_errors_serializer'

module ApiPack
  module_function

  PER_PAGE = 10

  attr_writer :default_per_page

  def default_per_page
    @default_per_page ||= PER_PAGE
  end
end
