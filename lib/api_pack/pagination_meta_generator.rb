require 'api_pack/support/api_helper'

module ApiPack
  class PaginationMetaGenerator
    include Support::ApiHelper

    def initialize(request:, total_pages:)
      @url = "#{request.base_url}#{request.path}"
      @page = request.params[:page].to_i
      @per_page = request.params[:per_page].to_i
      @total_pages = total_pages
    end

    def call
      {
        links: links,
        meta: {
          current_page: current_page,
          total_pages: @total_pages
        }
      }
    end

    private

    attr_accessor :url, :hash

    attr_reader :per_page, :page, :total_pages

    def links
      links = {
        self: generate_url,
        first: generate_url(number_page: 1),
        last: generate_url(number_page: total_pages)
      }

      links[:next] = generate_url(number_page: next_number(page)) if current_page != total_pages
      links[:prev] = generate_url(number_page: page - 1) if page > 1

      links
    end

    def generate_url(number_page: 0)
      return url if number_page.zero?

      [url, url_params(number_page)].join("?")
    end

    def url_params(number_page)
      url_params = {}
      url_params[:per_page] = include_per_page
      url_params[:page] = number_page

      to_query_api(url_params)
    end

    def include_per_page
      return ApiPack.default_per_page if per_page.zero?

      per_page
    end

    def next_number(number_page)
      return number_page + 2 if number_page.zero?

      number_page + 1
    end

    def current_page
      return 1 if page.zero?

      page
    end
  end
end
