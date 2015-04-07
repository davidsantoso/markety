module Markety
  module Response
    class SyncCustomObjectResponse < GenericResponse

      attr_accessor :status

      def initialize(response)
        super(:sync_custom_objects_response, response)
      end

      def success?
        @success
      end

      def custom_objects
        return [] unless success?
        @custom_objects ||= begin
          custom_obj_hash.map do |single_custom_obj_hash|
            CustomObject.from_marketo_hash(object_type_name, single_custom_obj_hash)
          end
        end
      end

      private

      def failed?
        status == "FAILED"
      end

      def object_type_name
        @object_type_name ||= custom_obj_hash.first.fetch(:obj_type_name)
      end

      def custom_obj_hash
        [to_hash[:success_sync_custom_objects][:result][:sync_custom_obj_status_list][:sync_custom_obj_status]].flatten
      end

    end
  end
end
