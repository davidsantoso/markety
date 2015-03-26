module Markety
  module Response
    class GetCustomObjectResponse < GenericResponse
      def initialize(response)
        super(:get_custom_object_response, response)
      end

      def custom_objects
        @custom_objects ||= begin
          custom_object_list.map do |custom_obj_hash|
            CustomObject.from_marketo_hash(object_type_name, custom_obj_hash)
          end
        end
      end

      def custom_object
        custom_objects.first
      end

      private

      def custom_object_list
        [custom_object_list_hash.fetch(:custom_obj, [])].flatten
      end

      def custom_object_list_hash
        result_hash[:custom_obj_list] || {}
      end

      def object_type_name
        result_hash.fetch(:obj_type_name, {})
      end

      def result_hash
        to_hash.fetch(:success_get_custom_objects, {}).fetch(:result, {})
      end
    end
  end
end
