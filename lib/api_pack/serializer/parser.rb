module ApiPack
  module Serializer
    module Parser
      module_function

      def serializer_hash(resource, klass, opt: {})
        adapter.serializer_hash(resource, klass, opt: opt)
      end

      def adapter
        return @adapter if @adapter

        self.adapter = :fast_json_api
        @adapter
      end

      def adapter=(adapter)
        require "./lib/api_pack/serializer/adapter/#{adapter}"

        adapter_name = adapter.to_s.split('_').collect(&:capitalize).join

        @adapter = Serializer::Adapter.const_get(adapter_name)
      end
    end
  end
end
