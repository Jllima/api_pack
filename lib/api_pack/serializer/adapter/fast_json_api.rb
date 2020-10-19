module ApiPack
  module Serializer
    module Adapter
      module FastJsonApi
        module_function

        def serializer_hash(resource, klass, opt: {})
          name_klass = klass.to_s.split('_').collect(&:capitalize).join

          serializer = "#{name_klass}Serializer"
          FastJsonapi.const_get(serializer).new(resource, opt).serializable_hash
        end
      end
    end
  end
end
