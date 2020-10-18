module Support
  module ApiHelper
    def to_query_api(params)
      query = params.collect do |key, value|
        "#{key}=#{value}"
      end.compact

      query.sort!
      query.join("&")
    end
  end
end
