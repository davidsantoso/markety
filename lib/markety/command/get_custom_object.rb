module Markety
  module Command
    module GetCustomObject

      # keys can be a hash or an array of hashes
      def get_custom_object_by_keys(object_type_name, keys)
        send_request(:get_custom_objects, {"objTypeName" => object_type_name, "customObjKeyList" => {"attribute" => convert_keys(keys)}})
      end

      def convert_keys(keys)
        keys.collect do |key, value|
          {"attrName" => key, "attrValue" => value}
        end
      end

    end
  end
end
