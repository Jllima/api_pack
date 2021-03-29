module ApiPack
  module ApiHelper
    def pagination_meta_generator(request, total_pages)
      ApiPack::PaginationMetaGenerator.new(request: request, total_pages: total_pages).call
    end

    def current_page
      return params[:page].to_i if defined?(params[:page]) && !params[:page].nil?

      ApiPack::DEFAULT_PAGE
    end

    def per_page
      return params[:per_page].to_i if defined?(params[:per_page]) && !params[:per_page].nil?

      ApiPack.default_per_page
    end

    def serializer_hash(resource, class_name, opt: {})
      ApiPack::Serializer::Parser.serializer_hash(resource, class_name, opt: opt)
    end
  end
end
