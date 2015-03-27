module Markety
  module Response
    class SyncCustomObjectResponse < GenericResponse

      attr_accessor :status

      def initialize(response)
        super(:sync_custom_objects_response, response)
      end

      def success?
        @success && !failed?
      end

      def status
        @status ||= custom_obj_hash[:status]
      end

      def error_message
        @error_message ||= custom_obj_hash[:error]
      end

      def updated_custom_object
        CustomObject.from_marketo_hash(object_type_name, custom_obj_hash) if success?
      end

      private

      def failed?
        status == "FAILED"
      end

      def object_type_name
        @object_type_name ||= custom_obj_hash[:obj_type_name]
      end

      def custom_obj_hash
        to_hash[:success_sync_custom_objects][:result][:sync_custom_obj_status_list][:sync_custom_obj_status]
      end

    end
  end
end
