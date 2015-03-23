module Markety
  module Response
    class GetCustomObjectResponse < GenericResponse
      attr_accessor :custom_objects
      def initialize(response)
        super(:get_custom_object_response, response)
        @custom_objects = []
        object_type_name = to_hash[:success_get_custom_objects][:result][:obj_type_name]
        custom_object_list.each do |custom_obj_hash|
          @custom_objects << CustomObject.from_marketo_hash(object_type_name, custom_obj_hash)
        end
      end

      def custom_object_list
        [(to_hash[:success_get_custom_objects][:result][:custom_obj_list] || {})[:custom_obj] || []].flatten
      end

      def custom_object
        custom_objects.first
      end
    end
  end
end
